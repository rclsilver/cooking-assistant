import logging

from celery import task
from django.db import transaction
from recipes import models
from recipes.parsers import get_parser, ParserException
from recipes.utils import create_recipe_from_dict


logger = logging.getLogger(__name__)


@task(bind=True)
def parse_recipes(self, *args, **kwargs):
    for source in models.Source.objects.filter(state=models.Source.STATE_TODO):
        try:
            parser = get_parser(source.source_url)
            logger.info('Parsing %s with %s...', source.source_url, parser)
            recipe = parser.parse()

            with transaction.atomic():
                recipe_obj = create_recipe_from_dict(recipe, source)
                source.state = models.Source.STATE_DONE
                source.error = None
                source.save()

            logger.info('Recipe has been created: %s', recipe_obj.pk)
        except Exception as e:
            source.state = models.Source.STATE_ERROR
            source.error = str(e)
            source.save()

            logger.error('Unable to parse recipe "%s": %s', source.source_url, e)
            logger.exception(e)
