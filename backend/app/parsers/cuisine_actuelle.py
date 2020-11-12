from app.parsers import BeautifulSoup, Parser, register_parser


class CuisineActuelleParser(Parser):
    """
    Parse recipes from https://www.cuisineactuelle.fr/
    """

    def _fetch_title(self, dom: BeautifulSoup) -> str:
        """
        Fetch the title from the dom
        """
        for meta in dom.find_all('meta'):
            if 'parsely-title' == meta.get('name'):
                return meta.get('content')

    def _fetch_image(self, dom: BeautifulSoup) -> str:
        """
        Fetch the image from the dom
        """
        lead_image_div = dom.find('div', attrs={ 'class': 'leadImage-image' })
        img = lead_image_div.find('img')
        return img.get('src')

    def _parse_content(self, dom: BeautifulSoup) -> None:
        """
        Parse content from the BeautifulSoup and update self._result
        """
        self._result[self.TITLE] = self._fetch_title(dom)
        self._result[self.IMAGE] = self._fetch_image(dom)


register_parser(r'^https://(www\.)?cuisineactuelle.fr/recettes/.+$', CuisineActuelleParser)


if __name__ == '__main__':
    import logging
    from app.parsers import get_parser
    logging.basicConfig(format='[%(levelname)s] %(message)s', level=logging.DEBUG)
    parser = get_parser('https://www.cuisineactuelle.fr/recettes/quiche-lorraine-au-lait-198596#')
    content = parser.parse()
    print(f'URL: {parser._url}')
    for key, value in content.items():
        print(f'- {key} => [{value}]')
