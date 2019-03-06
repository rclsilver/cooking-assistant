from django.contrib.auth import get_user_model
from django.contrib.postgres.search import SearchQuery, SearchVector
from django.db.models import Q
from django.http import HttpResponse
from django.utils import timezone
from django.utils.cache import patch_cache_control
from recipes import models
from recipes import serializers
from rest_framework import mixins
from rest_framework import permissions
from rest_framework import viewsets
from rest_framework import status
from rest_framework.decorators import action
from rest_framework.response import Response
from rest_framework.exceptions import ValidationError
from rest_framework_extensions.mixins import NestedViewSetMixin


class PictureMixin(object):
    @action(detail=True)
    def picture(self, request, pk=None):
        self.object = self.get_object()

        if not self.object.picture:
            return HttpResponse(status=404)

        response = HttpResponse(
            bytes(self.object.picture.data),
            content_type='image/{}'.format(self.object.picture.format.lower()),
        )
        response['Content-Disposition'] = 'inline; filename="{}.{}"'.format(
            self.object.picture.pk,
            self.object.picture.format.lower(),
        )

        # Tell client to cache this content
        patch_cache_control(response, max_age=3600)

        return response


class UserViewSet(viewsets.ReadOnlyModelViewSet):
    queryset = get_user_model().objects.all()
    serializer_class = serializers.UserSerializer
    permission_classes = (permissions.IsAuthenticated,)

    def get_object(self):
        if 'me' == self.kwargs['pk']:
            return self.request.user
        else:
            return super(UserViewSet, self).get_object()


class UnitViewSet(viewsets.ModelViewSet):
    queryset = models.Unit.objects.all()
    serializer_class = serializers.UnitSerializer
    permission_classes = (permissions.IsAuthenticatedOrReadOnly,)


class IngredientViewSet(PictureMixin, viewsets.ModelViewSet):
    queryset = models.Ingredient.objects.all()
    serializer_class = serializers.IngredientSerializer
    permission_classes = (permissions.IsAuthenticatedOrReadOnly,)


class SourceViewSet(viewsets.ModelViewSet):
    queryset = models.Source.objects.all()
    serializer_class = serializers.SourceSerializer
    permission_classes = (permissions.IsAuthenticatedOrReadOnly,)

    def perform_create(self, serializer):
        serializer.save(author=self.request.user)

    def get_queryset(self):
        queryset = super(SourceViewSet, self).get_queryset()
        states = self.request.query_params.get('state', '').split(',')
        state_filters = None

        for state in states:
            if state:
                if state_filters is None:
                    state_filters = Q(state=state)
                else:
                    state_filters = state_filters | Q(state=state)

        if state_filters is not None:
            return queryset.filter(state_filters)

        return queryset

    @action(detail=True, methods=['post'])
    def retry(self, request, pk=None):
        source = self.get_object()
        if source.state not in [4]:
            return Response(status=status.HTTP_400_BAD_REQUEST)
        source.state = 1
        source.error = None
        source.save()
        serializer = self.serializer_class(source)
        return Response(serializer.data, status=status.HTTP_200_OK)


class RecipeViewSet(PictureMixin, viewsets.ModelViewSet):
    queryset = models.Recipe.objects.all()
    serializer_class = serializers.RecipeSerializer
    permission_classes = (permissions.IsAuthenticatedOrReadOnly,)

    def get_queryset(self):
        queryset = super(RecipeViewSet, self).get_queryset()
        search = self.request.query_params.get('search', '')

        if len(search):
            return queryset.annotate(
                search=SearchVector('title', config='french_unaccent'),
            ).filter(
                search=SearchQuery(search, config='french_unaccent')
            )

        return queryset


class RequiredIngredientViewSet(viewsets.ModelViewSet):
    queryset = models.RequiredIngredient.objects.all()
    serializer_class = serializers.RequiredIngredientSerializer
    permission_classes = (permissions.IsAuthenticatedOrReadOnly,)


class RatingViewSet(viewsets.ModelViewSet):
    queryset = models.Period.objects.all().order_by('start_date')
    serializer_class = serializers.RatingSerializer
    permission_classes = (permissions.IsAuthenticatedOrReadOnly,)


class PeriodViewSet(NestedViewSetMixin, viewsets.ModelViewSet):
    queryset = models.Period.objects.all().order_by('start_date')
    serializer_class = serializers.PeriodSerializer
    permission_classes = (permissions.IsAuthenticatedOrReadOnly,)

    def get_queryset(self):
        queryset = super(PeriodViewSet, self).get_queryset()

        if (
            'list' == self.action and
            'true' != self.request.query_params.get('past', 'false').lower()
        ):
            return queryset.filter(end_date__gte=timezone.now())

        return queryset

    def perform_create(self, serializer):
        serializer.save(author=self.request.user)


class RecipeInPeriodViewSet(NestedViewSetMixin, viewsets.ModelViewSet):
    queryset = models.RecipeInPeriod.objects.all()
    serializer_class = serializers.RecipeInPeriodSerializer
    permission_classes = (permissions.IsAuthenticatedOrReadOnly,)

    def get_period(self):
        return models.Period.objects.get(
            pk=self.kwargs.get('parent_lookup_period'),
        )

    def validate_date(self, data, period):
        if 'date' in data and data['date'] is not None:
            if (
                data['date'] < period.start_date or
                data['date'] > period.end_date
            ):
                raise ValidationError({
                    'date': ['Date {} is not between {} and {}'.format(
                        data['date'],
                        period.start_date,
                        period.end_date,
                    )],
                })

    def create(self, request, *args, **kwargs):
        # Validate input data
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)

        # Fetch parent period
        period = self.get_period()

        # Validate that date is between period dates
        self.validate_date(serializer.validated_data, period)

        # Save recipe
        recipe = serializer.save(
            author=self.request.user,
            period=period,
        )

        # Build serializer with created date
        serializer = serializers.RecipeInPeriodSerializer(recipe)

        # Back to normal routine
        headers = self.get_success_headers(serializer.data)
        return Response(serializer.data, status=status.HTTP_201_CREATED, headers=headers)

    def perform_update(self, serializer):
        # Validate that date is between period dates
        self.validate_date(
            serializer.validated_data,
            self.get_period()
        )

        # Save
        serializer.save()

    def get_serializer_class(self):
        if self.action in ['create']:
            return serializers.AddRecipeInPeriodSerializer
        elif self.action in ['update', 'partial_update']:
            return serializers.UpdateRecipeInPeriodSerializer
        return super(RecipeInPeriodViewSet, self).get_serializer_class()
