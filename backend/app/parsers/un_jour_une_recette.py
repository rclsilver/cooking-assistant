from app.parsers import BeautifulSoup, Parser, register_parser


class UnJourUneRecetteParser(Parser):
    """
    Parse recipes from https://www.unjourunerecette.fr/
    """

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
        img = dom.find(id='grossephoto')
        if img:
            return 'https://www.unjourunerecette.fr/{}'.format(
                img.get('src')
            )

    def _parse_content(self, dom: BeautifulSoup) -> None:
        """
        Parse content from the BeautifulSoup and update self._result
        """
        self._result[self.TITLE] = self._fetch_title(dom)
        self._result[self.IMAGE] = self._fetch_image(dom)


register_parser(r'^https://(www\.)?unjourunerecette.fr/.+$', UnJourUneRecetteParser)


if __name__ == '__main__':
    import logging
    from app.parsers import get_parser
    logging.basicConfig(format='[%(levelname)s] %(message)s', level=logging.DEBUG)
    parser = get_parser('https://www.unjourunerecette.fr/recette-salade-de-chevre-chaud')
    content = parser.parse()
    print(f'URL: {parser._url}')
    for key, value in content.items():
        print(f'- {key} => [{value}]')
