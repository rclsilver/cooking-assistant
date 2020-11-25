from app.parsers import BeautifulSoup, Parser, register_parser


class MarmitonParser(Parser):
    """
    Parse recipes from https://www.marmiton.org/
    """

    def _fetch_title(self, dom: BeautifulSoup) -> str:
        """
        Fetch the title from the dom
        """
        for meta in dom.find_all('meta'):
            if 'og:title' == meta.get('property'):
                return meta.get('content')

    def _fetch_image(self, dom: BeautifulSoup) -> str:
        """
        Fetch the image from the dom
        """
        for meta in dom.find_all('meta'):
            if 'og:image' == meta.get('property'):
                return meta.get('content')

    def _parse_content(self, dom: BeautifulSoup) -> None:
        """
        Parse content from the BeautifulSoup and update self._result
        """
        self._result[self.TITLE] = self._fetch_title(dom)
        self._result[self.IMAGE] = self._fetch_image(dom)


register_parser(r'^https://(www\.)?marmiton\.org/recettes/.+\.aspx$', MarmitonParser)


if __name__ == '__main__':
    import logging
    from app.parsers import get_parser
    logging.basicConfig(format='[%(levelname)s] %(message)s', level=logging.DEBUG)
    parser = get_parser('https://www.marmiton.org/recettes/recette_carbonades-flamandes-traditionnelles_29711.aspx')
    content = parser.parse()
    print(f'URL: {parser._url}')
    for key, value in content.items():
        print(f'- {key} => [{value}]')
