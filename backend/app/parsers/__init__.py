import logging
import re
import requests

from bs4 import BeautifulSoup
from typing import Dict, Optional, Type


logger = logging.getLogger(__name__)
__parsers__ = {}


class ParserException(Exception):
    """
    Base parser exception
    """
    pass


class Parser:
    """
    Base parser class
    """
    TITLE = 'title'
    IMAGE = 'image'

    def __init__(self, url: str) -> None:
        """
        Initialize the parser
        """
        self._url = url
        self._result = {
            self.TITLE: '',
            self.IMAGE: ''
        }

    def _fetch_html(self, url: Optional[str] = None, *args, **kwargs) -> str:
        """
        Fetch the HTML content from the URL
        """
        if not url:
            url = self._url
        res = requests.get(url, *args, **kwargs)
        if not res.ok:
            raise ParserException(
                f'Invalid HTTP response for URL "{url}": {res.status_code}'
            )
        return res.text

    def _parse_dom(self, html: str) -> BeautifulSoup:
        """
        Parse input HTML and return a BeautifulSoup instance
        """
        return BeautifulSoup(html, 'html.parser')

    def _parse_content(self, dom: BeautifulSoup) -> None:
        """
        Parse content from the BeautifulSoup and update self._result
        """
        raise NotImplementedError

    def _check_content(self) -> None:
        """
        Check the result
        """
        if not self._result[self.TITLE]:
            raise ParserException(self.TITLE)

        if not self._result[self.IMAGE]:
            raise ParserException(self.IMAGE)

    def parse(self) -> Dict:
        """
        Parse the URL and return the content
        """
        html = self._fetch_html()
        dom = self._parse_dom(html)
        self._parse_content(dom)
        self._check_content()
        return self._result


def register_parser(url: str, parser_class: Type[Parser]) -> None:
    """
    Register a new parser
    """
    logger.debug(
        'Registering %s parser class for URL %s',
        parser_class.__name__,
        url
    )
    __parsers__[url] = parser_class


def get_parser(url: str) -> Parser:
    """
    Get registered parser from the URL
    """
    for url_pattern, parser_class in __parsers__.items():
        if re.match(url_pattern, url):
            logger.debug(
                'Found %s parser class for URL %s',
                parser_class.__name__,
                url
            )
            return parser_class(url)
    raise ParserException('No parser found for this URL')


from app.parsers.cuisine_actuelle import CuisineActuelleParser
from app.parsers.marmiton import MarmitonParser
from app.parsers.un_jour_une_recette import UnJourUneRecetteParser
from app.parsers.envie_de_bien_manger import EnvieDeBienMangerParser
from app.parsers.sept_cent_cinquante_grammes import SeptCentCinquanteGrammesParser
