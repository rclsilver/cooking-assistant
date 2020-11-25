#!/usr/bin/env python

import argparse
import requests
import time

from app.database import SessionLocal
from app.controllers.recipe import RecipeController
from app.controllers.user import UserController
from app.schemas.recipe import RecipeImport


def main(args):
    db = SessionLocal()

    author = UserController.get_or_create_user('thomas.betrancourt', True, db)

    while args.number > 0:
        try:
            r = requests.get('https://www.marmiton.org/recettes/recette-hasard.aspx', allow_redirects=False)
            r.raise_for_status()

            recipe = RecipeController.import_recipe(
                RecipeImport(url=r.headers.get('Location')),
                author,
                db
            )
            RecipeController.fetch_recipe_informations(recipe, db)

            print('[{}] {}'.format(recipe.id, recipe.title))

            args.number -= 1
        except requests.RequestException:
            pass

        time.sleep(1)


if '__main__' == __name__:
    parser = argparse.ArgumentParser()
    parser.add_argument('-n', '--number', default=10, type=int)
    args = parser.parse_args()
    main(args)
