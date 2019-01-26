from recipes.parsers import Parser, register_parser


class MarmitonParser(Parser):
    def parse_content(self, dom):
        # Parsing meta
        for meta in dom.find_all('meta'):
            if 'og:title' == meta.get('property'):
                self._result[self.TITLE] = meta.get('content')
            elif 'og:image' == meta.get('property'):
                self._result[self.IMAGE] = meta.get('content')

        # Parsing ingredients
        for item in dom.find_all('li', {'class': 'recipe-ingredients__list__item'}):
            self._result[self.INGREDIENTS].append(
                self.parse_ingredient(
                    label=self.get_attr_value(item, 'p', {'class': 'name_singular'}, 'data-name-singular'),
                    quantity=self.get_attr_value(item, 'span', {'class': 'recipe-ingredient-qt'}, 'data-base-qt'),
                    image=self.get_attr_value(item, 'img', {'class': 'ingredients-list__item__icon'}, 'src'),
                )
            )

        # Parsing informations
        self._result[self.PERSONS] = self.get_text(
            dom,
            'span',
            {'class': 'recipe-infos__quantity__value'},
            default_value='0',
        )

        self._result[self.DIFFICULTY] = self.parse_difficulty(
            self.get_text(
                dom.find('div', {'class': 'recipe-infos__level'}),
                'span',
                {'class': 'recipe-infos__item-title'},
            )
        )

        self._result[self.COST] = self.parse_cost(
            self.get_text(
                dom.find('div', {'class': 'recipe-infos__budget'}),
                'span',
                {'class': 'recipe-infos__item-title'},
            )
        )

        # Parsing times
        self._result[self.PREPARATION_TIME] = self.parse_duration(
            self.get_text(
                dom.find('div', {'class': 'recipe-infos__timmings__preparation'}),
                'span',
                {'class': 'recipe-infos__timmings__value'},
                default_value='0',
            ),
            self.PREPARATION_TIME
        )
        self._result[self.COOKING_TIME] = self.parse_duration(
            self.get_text(
                dom.find('div', {'class': 'recipe-infos__timmings__cooking'}),
                'span',
                {'class': 'recipe-infos__timmings__value'},
                default_value='0',
            ),
            self.COOKING_TIME,
        )

        # Parsing steps
        self._result[self.STEPS] = []
        for list_item in dom.find('ol', {'class': 'recipe-preparation__list'}).find_all('li'):
            list_item.find('h3').decompose()
            self._result[self.STEPS].append(self.clean_text(list_item.text))
        
register_parser(r'^https://(www\.)?marmiton\.org/recettes/.+\.aspx$', MarmitonParser)
