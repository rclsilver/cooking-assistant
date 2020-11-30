from app.parsers import BeautifulSoup, Parser, register_parser


class SeptCentCinquanteGrammesParser(Parser):
    """
    Parse recipes from https://www.750g.com/
    """

    def _fetch_title(self, dom: BeautifulSoup) -> str:
        """
        Fetch the title from the dom
        """
        span = dom.find('span', { 'class': 'u-title-page' })
        if span:
            return span.text

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


register_parser(r'^https://(www\.)?750g.com/.+$', SeptCentCinquanteGrammesParser)


if __name__ == '__main__':
    import logging
    from app.parsers import get_parser
    logging.basicConfig(format='[%(levelname)s] %(message)s', level=logging.DEBUG)
    for url in [
        'https://www.750g.com/omelette-aux-cepes-et-ses-lardons-r63757.htm',
        'https://www.750g.com/petits-pois-a-la-francaise-r52519.htm'
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
