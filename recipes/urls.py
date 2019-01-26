from django.urls import include, path
from recipes import views
from rest_framework import routers


router = routers.DefaultRouter(trailing_slash=False)
router.register(
    'units',
    views.UnitViewSet,
    base_name='unit',
)
router.register(
    'ingredients',
    views.IngredientViewSet,
    base_name='ingredient',
)
router.register(
    'sources',
    views.SourceViewSet,
    base_name='sources',
)
router.register(
    'recipes',
    views.RecipeViewSet,
    base_name='recipe',
)
router.register(
    'users',
    views.UserViewSet,
    base_name='user',
)

urlpatterns = [
    path('', include(router.urls)),
]
