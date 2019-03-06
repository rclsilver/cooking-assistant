from django.contrib.auth import get_user_model
from django.db.models import Avg, Min, Max
from django.urls import reverse_lazy
from django.utils import timezone
from recipes import models
from rest_framework import (
    exceptions,
    serializers,
)


class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = get_user_model()
        fields = ('username', 'first_name', 'last_name', 'email')


class RatingSerializer(serializers.ModelSerializer):
    author = UserSerializer(read_only=True)

    class Meta:
        model = models.Rating
        fields = '__all__'


class UnitSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.Unit
        fields = '__all__'


class IngredientSerializer(serializers.ModelSerializer):
    picture_url = serializers.SerializerMethodField()

    def get_picture_url(self, obj):
        return reverse_lazy('ingredient-picture', kwargs=dict(pk=obj.pk))

    class Meta:
        model = models.Ingredient
        exclude = ('picture',)


class RequiredIngredientSerializer(serializers.ModelSerializer):
    ingredient = IngredientSerializer()
    unit = UnitSerializer()

    class Meta:
        model = models.RequiredIngredient
        fields = '__all__'


class SourceSerializer(serializers.ModelSerializer):
    author = UserSerializer(read_only=True)
    recipes = serializers.SerializerMethodField()

    def get_recipes(self, obj):
        return obj.recipes.count()

    class Meta:
        model = models.Source
        fields = '__all__'
        read_only_fields = ('state', 'error')


class RecipeSerializer(serializers.ModelSerializer):
    author = UserSerializer(read_only=True)
    picture_url = serializers.SerializerMethodField()
    ingredients = RequiredIngredientSerializer(many=True)
    ratings = RatingSerializer(many=True)
    rate = serializers.SerializerMethodField()
    source_url = serializers.SerializerMethodField()

    def get_picture_url(self, obj):
        return reverse_lazy('recipe-picture', kwargs=dict(pk=obj.pk))

    def get_rate(self, obj):
        return obj.ratings.all().aggregate(Avg('rate'))['rate__avg']

    def get_source_url(self, obj):
        return obj.source.source_url

    class Meta:
        model = models.Recipe
        exclude = ('picture',)


class PeriodSerializer(serializers.ModelSerializer):
    author = UserSerializer(read_only=True)
    recipes = serializers.SerializerMethodField()

    def get_recipes(self, obj):
        return obj.recipes.count()

    def validate_end_date(self, value):
        if value < timezone.now().date():
            raise exceptions.ValidationError('Date cannot be in past')
        return value

    def validate(self, attrs):
        start_date = attrs.get(
            'start_date',
            self.instance.start_date if self.instance else None
        )
        end_date = attrs.get(
            'end_date',
            self.instance.end_date if self.instance else None
        )

        if start_date >= end_date:
            raise exceptions.ValidationError({
                'start_date': [
                    'Date must be strictly before {}'.format(end_date),
                ],
                'end_date': [
                    'Date must be strictly after {}'.format(start_date),
                ],
            })

        if self.instance:
            bounds = self.instance.recipes.aggregate(
                Min('date'),
                Max('date'),
            )

            if (
                bounds['date__min'] is not None and
                bounds['date__min'] < start_date
            ):
                raise exceptions.ValidationError({
                    'start_date': [
                        'Cannot be defined after {}'.format(bounds['date__min'])
                    ]
                })

            if (
                bounds['date__max'] is not None and
                bounds['date__max'] > end_date
            ):
                raise exceptions.ValidationError({
                    'end_date': [
                        'Cannot be defined before {}'.format(bounds['date__max'])
                    ]
                })

        return attrs

    class Meta:
        model = models.Period
        fields = '__all__'


class RecipeInPeriodSerializer(serializers.ModelSerializer):
    author = UserSerializer(read_only=True)
    recipe = RecipeSerializer(read_only=True)

    class Meta:
        model = models.RecipeInPeriod
        exclude = ('period',)


class RecipeInPeriodSerializerMixins(object):
    def validate(self, attrs):
        date = attrs.get('date', self.instance.date if self.instance is not None else None)
        meal = attrs.get('meal', self.instance.meal if self.instance is not None else None)

        if (
            date is None and meal is not None
        ) or (
            date is not None and meal is None
        ):
            raise serializers.ValidationError(
                {
                    'date' if date is None else 'meal': [
                        'Must be defined when {} is defined'.format(
                            'meal' if meal is not None else 'date',
                        )
                    ]
                }
            )

        return attrs


class AddRecipeInPeriodSerializer(RecipeInPeriodSerializerMixins, serializers.ModelSerializer):
    date = serializers.DateField(required=False, allow_null=True)
    meal = serializers.IntegerField(required=False, allow_null=True)

    class Meta:
        model = models.RecipeInPeriod
        fields = ('recipe', 'date', 'meal')


class UpdateRecipeInPeriodSerializer(RecipeInPeriodSerializerMixins, serializers.ModelSerializer):
    date = serializers.DateField(required=False, allow_null=True)
    meal = serializers.IntegerField(required=False, allow_null=True)

    class Meta:
        model = models.RecipeInPeriod
        fields = ('date', 'meal')
