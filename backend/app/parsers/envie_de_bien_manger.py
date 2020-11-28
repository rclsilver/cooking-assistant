import re

from app.parsers import BeautifulSoup, Parser, register_parser


class EnvieDeBienMangerParser(Parser):
    """
    Parse recipes from https://www.enviedebienmanger.fr/
    """

    _BASE_URL = 'https://www.enviedebienmanger.fr'

    def _search_recipe(self) -> BeautifulSoup:
        """
        Search recipe and return result page dom
        """
        pattern = self._result[self.TITLE]
        html = self._fetch_html(
            f'{self._BASE_URL}/recettes',
            params={
                'search_api_fulltext': pattern
            }
        )
        return self._parse_dom(html)

    def _fetch_title(self, dom: BeautifulSoup) -> str:
        """
        Fetch the title from the dom
        """
        h1 = dom.find('h1')
        if h1:
            return h1.text

    def _fetch_image(self, dom: BeautifulSoup) -> str:
        """
        Fetch the image from the dom
        """
        search_dom = self._search_recipe()
        div = search_dom.find('div', { 'id': 'all-items' })

        for li in div.find_all('li'):
            article = li.find('article')
            about = article.get('about')
            if f'{self._BASE_URL}{about}' == self._url:
                div_visuel = article.find('div', { 'class': 'desktop visuel' })
                img = div_visuel.find('img')
                return re.sub(r'^([^?]+)(?:\?.+)?$', r'\1', img.get('data-src'))

    def _parse_content(self, dom: BeautifulSoup) -> None:
        """
        Parse content from the BeautifulSoup and update self._result
        """
        self._result[self.TITLE] = self._fetch_title(dom)
        self._result[self.IMAGE] = self._fetch_image(dom)


register_parser(r'^https://(www\.)?enviedebienmanger.fr/fiche-recette/.+$', EnvieDeBienMangerParser)


if __name__ == '__main__':
    import logging
    from app.parsers import get_parser
    logging.basicConfig(format='[%(levelname)s] %(message)s', level=logging.DEBUG)
    for url in [
        'https://www.enviedebienmanger.fr/fiche-recette/recette-burger-sauce-aux-3-poivres',
        'https://www.enviedebienmanger.fr/fiche-recette/recette-courge-butternut-farcie-au-riz-sauvage-petits-pois-et-roquefort'
    ]:
        try:
            parser = get_parser(url)
            content = parser.parse()
            print(f'URL: {parser._url}')
            for key, value in content.items():
                print(f'- {key} => [{value}]')
        except Exception as e:
            print(f'Unable to parse recipe from {url}')
            print(e)
