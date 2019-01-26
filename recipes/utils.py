import io
import logging
import requests

from django.db.models import Q
from PIL import Image
from recipes import models
from recipes.parsers import Parser


logger = logging.getLogger(__name__)


def create_picture_object(url):
    logger.info('Loading image from %s', url)

    r = requests.get(url, stream=True)

    if not r.ok:
        logger.warn('Unable to load image from %s: status code %d', url, r.status_code)
        return None

    try:
        # Open image from URL
        image = Image.open(r.raw)

        # Fetch compressed bytes
        image_bytes = io.BytesIO()
        image.save(image_bytes, format=image.format)

        # Save picture to database
        picture = models.Picture(
            data = image_bytes.getvalue(),
            format = image.format,
            mode = image.mode,
            width = image.width,
            height = image.height,
        )
        picture.save()
        logger.info('Created picture from %s: %s', url, picture.pk)
        return picture
    except Exception as e:
        logger.warn('Unable to load image from %s: %s', url, str(e))
        logger.exception(e)
        return None


def create_recipe_from_dict(data, source):
    recipe = models.Recipe(
        source=source,
        author=source.author,
        title=data[Parser.TITLE],
        picture=create_picture_object(data[Parser.IMAGE]) if data[Parser.IMAGE] else None,
        preparation_time=data[Parser.PREPARATION_TIME] if data[Parser.PREPARATION_TIME] else None,
        cooking_time=data[Parser.COOKING_TIME] if data[Parser.COOKING_TIME] else None,
        difficulty=data[Parser.DIFFICULTY] if data[Parser.DIFFICULTY] else None,
        cost=data[Parser.COST] if data[Parser.COST] else None,
        persons=data[Parser.PERSONS] if data[Parser.PERSONS] else None,
        steps=data[Parser.STEPS] if data[Parser.STEPS] else None,
    )
    recipe.save()

    for ingredient in data[Parser.INGREDIENTS]:
        # Prepare unit
        if ingredient['unit']:
            if not models.Unit.objects.filter(symbol=ingredient['unit']).exists():
                unit = models.Unit(
                    symbol=ingredient['unit'],
                    label=ingredient['unit'],
                )
                unit.save()
                logger.info('A new Unit has been created with symbol "%s" (%s)', unit.symbol, unit.pk)
            else:
                try:
                    unit = models.Unit.objects.get(symbol=ingredient['unit'])
                except Exception as e:
                    logger.error('Unable to fetch unit with symbol="%s"', ingredient['unit'])
                    raise
        else:
            unit = None

        # Create or get ingredient
        if not models.Ingredient.objects.filter(Q(label=ingredient['name']) | Q(synonyms__contains=[ingredient['name']])).exists():
            ingredient_obj = models.Ingredient(
                label=ingredient['name'],
                picture=create_picture_object(ingredient['image']) if ingredient['image'] else None,
            )
            ingredient_obj.save()
            logger.info('A new Ingredient has been created with label "%s" (%s)', ingredient_obj.label, ingredient_obj.pk)
        else:
            try:
                ingredient_obj = models.Ingredient.objects.get(Q(label=ingredient['name']) | Q(synonyms__contains=[ingredient['name']]))
            except Exception as e:
                logger.error('Unable to fetch ingredient with name="%s"', ingredient['name'])
                raise
    
        # Create link between version and ingredient
        required_ingredient = models.RequiredIngredient(
            recipe=recipe,
            ingredient=ingredient_obj,
            unit=unit,
            quantity=ingredient['quantity'],
        )
        required_ingredient.save()

    return recipe
