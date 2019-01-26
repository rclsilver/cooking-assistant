from django.contrib.auth import get_user_model
from django.contrib.postgres.fields import ArrayField
from django.db import models
from cooking_assistant.models import Base


class Picture(Base):
    data = models.BinaryField()
    format = models.CharField(max_length=64)
    mode = models.CharField(max_length=8)
    width = models.IntegerField()
    height = models.IntegerField()


class Unit(Base):
    symbol = models.CharField(max_length=8, unique=True)
    label = models.CharField(max_length=64)
    label_plural = models.CharField(max_length=64, null=True, blank=True)


class Ingredient(Base):
    label = models.CharField(max_length=64, unique=True)
    synonyms = ArrayField(models.CharField(max_length=64), null=True, blank=True)
    picture = models.ForeignKey(Picture, null=True, blank=True, on_delete=models.SET_NULL)


class Source(Base):
    STATE_TODO = 1
    STATE_DOING = 2
    STATE_DONE = 3
    STATE_ERROR = 4
    STATE_CHOICES = (
        (STATE_TODO, 'todo'),
        (STATE_DOING, 'doing'),
        (STATE_DONE, 'done'),
        (STATE_ERROR, 'error'),
    )

    author = models.ForeignKey(get_user_model(), on_delete=models.SET_NULL, null=True, blank=True)
    source_url = models.URLField(unique=True)
    state = models.IntegerField(choices=STATE_CHOICES, default=STATE_TODO)
    error = models.TextField(null=True, blank=True)


class Recipe(Base):
    source = models.ForeignKey(Source, related_name='recipes', on_delete=models.CASCADE, null=True, blank=True)
    author = models.ForeignKey(get_user_model(), on_delete=models.SET_NULL, null=True, blank=True)
    title = models.CharField(max_length=128)
    picture = models.ForeignKey(Picture, null=True, blank=True, on_delete=models.SET_NULL)
    description = models.CharField(max_length=128, null=True, blank=True)
    preparation_time = models.IntegerField(null=True, blank=True)
    cooking_time = models.IntegerField(null=True, blank=True)
    difficulty = models.IntegerField(null=True, blank=True)
    cost = models.IntegerField(null=True, blank=True)
    persons = models.IntegerField()
    published = models.BooleanField(default=False)
    steps = ArrayField(models.TextField())


class RequiredIngredient(Base):
    recipe = models.ForeignKey(Recipe, related_name='ingredients', on_delete=models.CASCADE)
    ingredient = models.ForeignKey(Ingredient, on_delete=models.PROTECT)
    unit = models.ForeignKey(Unit, null=True, blank=True, on_delete=models.PROTECT)
    quantity = models.DecimalField(max_digits=10, decimal_places=4, null=True, blank=True)


class Rating(Base):
    author = models.ForeignKey(get_user_model(), on_delete=models.CASCADE, null=True, blank=True)
    recipe = models.ForeignKey(Recipe, related_name='ratings', on_delete=models.CASCADE)
    rate = models.IntegerField()
    comment = models.TextField(null=True, blank=True)

    class Meta:
        unique_together = (
            ('author', 'recipe'),
        )
