from django.contrib.auth import get_user_model
from django.http import HttpResponse
from django.utils.cache import patch_cache_control
from recipes import models
from recipes import serializers
from rest_framework import mixins
from rest_framework import permissions
from rest_framework import viewsets
from rest_framework.decorators import action


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
