from django.contrib.auth import get_user_model
from django.db.models import Q
from django.http import HttpResponse
from django.utils.cache import patch_cache_control
from recipes import models
from recipes import serializers
from rest_framework import mixins
from rest_framework import permissions
from rest_framework import viewsets
from rest_framework import status
from rest_framework.decorators import action
from rest_framework.response import Response


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


class RequiredIngredientViewSet(viewsets.ModelViewSet):
    queryset = models.RequiredIngredient.objects.all()
    serializer_class = serializers.RequiredIngredientSerializer
    permission_classes = (permissions.IsAuthenticatedOrReadOnly,)


class RatingViewSet(viewsets.ModelViewSet):
    queryset = models.Rating.objects.all()
    serializer_class = serializers.RatingSerializer
    permission_classes = (permissions.IsAuthenticatedOrReadOnly,)
