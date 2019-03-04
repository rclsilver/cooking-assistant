from django.urls import include, path
from recipes import views
from rest_framework_extensions import routers


router = routers.ExtendedDefaultRouter(trailing_slash=False)
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

# Periods
periods_router = router.register(
    'periods',
    views.PeriodViewSet,
    base_name='period',
)
periods_router.register(
    'recipes',
    views.RecipeInPeriodViewSet,
    base_name='recipe-in-period',
    parents_query_lookups=['period'],
)

urlpatterns = [
    path('', include(router.urls)),
]
