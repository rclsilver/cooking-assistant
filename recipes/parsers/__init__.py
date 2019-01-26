import logging
import re
import requests

from bs4 import BeautifulSoup


logger = logging.getLogger(__name__)
__parsers__ = {}


class ParserException(Exception):
    pass


def register_parser(url, cls):
    __parsers__[url] = cls


def get_parser(url):
    for urlpattern, cls in __parsers__.items():
        logging.info('Matching "{}" with "{}"'.format(url, urlpattern))
        if re.match(urlpattern, url):
            return cls(url)
    raise ParserException('No parser found for this URL')


class Parser(object):
    TITLE = 'title'
    IMAGE = 'image'
    PREPARATION_TIME = 'preparation_time'
    COOKING_TIME = 'cooking_time'
    INGREDIENTS = 'ingredients'
    PERSONS = 'persons'
    DIFFICULTY = 'difficulty'
    COST = 'cost'
    STEPS = 'steps'

    def __init__(self, url):
        self._url = url
        self._result = {
            self.TITLE: None,
            self.IMAGE: None,
            self.PREPARATION_TIME: None,
            self.COOKING_TIME: None,
            self.INGREDIENTS: [],
            self.PERSONS: None,
            self.DIFFICULTY: None,
            self.COST: None,
            self.STEPS: [],
        }

    def fetch_html(self):
        response = requests.get(self._url)
        return response.text

    def parse_dom(self, html_doc):
        return BeautifulSoup(html_doc, 'html.parser')

    def clean_text(self, txt):
        if txt is None:
            return None
        txt = txt.replace('\r', '') \
                  .replace('\n', '') \
                  .replace('\t', '') \
                  .strip()
        return re.sub(' {2,}', ' ', txt)

    def get_attr_value(self, parent, tag, filters, attr_name, default_value=None, clean_func=clean_text):
        item = parent.find(tag, filters)
        if item:
            value = item.get(attr_name) or default_value
        else:
            value = default_value
        return clean_func(self, value) if clean_func else value

    def get_text(self, parent, tag, filters, default_value=None, clean_func=clean_text):
        if parent:
            item = parent.find(tag, filters)
        else:
            item = None
        if item:
            value = item.text or default_value
        else:
            value = default_value
        return clean_func(self, value) if clean_func else value

    def convert_quantity(self, source_multiple, quantity):
        multiples = ('k', 'da', 'h', None, 'd', 'c', 'm')
        i_unit = multiples.index(None)
        i_multiple = multiples.index(source_multiple)
        return float(quantity) * float(10 ** (i_unit - i_multiple))

    def parse_ingredient(self, label, quantity=None, image=None):
        try:
            m_1 = re.match(r'^(?P<unit>.+?)\s+(?:de\s+|d\')(?P<label>\S+.*)$', label)

            if m_1:
                m_2 = re.match(r'^(?P<multiple>[kdcm])?(?P<unit>[lLg])$', m_1.group('unit'))

                if m_2:
                    return {
                        'name': m_1.group('label'),
                        'quantity': self.convert_quantity(m_2.group('multiple'), quantity),
                        'unit': m_2.group('unit'),
                        'image': image,
                    }
                else:
                    for r in [
                        '^(tranche)s?$',
                        '^(?:petite|grosse )?(cuillères? à (?:soupe|café))$',
                        '^(pincée)s?$',
                        '^(gousse)s?$',
                    ]:
                        m = re.match(r, m_1.group('unit'))

                        symbols = {
                            'cuillère à soupe': 'cs',
                            'cuillères à soupe': 'cs',
                            'cuillère à café': 'cc',
                            'cuillères à café': 'cc',
                            'tranche': 'tr',
                            'pincée': 'pi',
                            'gousse': 'go',
                        }

                        if m:
                            return {
                                'name': m_1.group('label'),
                                'quantity': quantity,
                                'unit': symbols[m.group(1)] if m.group(1) in symbols else m.group(1),
                                'image': image,
                            }

            return {
                'name': label.strip().lower(),
                'quantity': float(quantity) if quantity else None,
                'unit': None,
                'image': image,
            }
        except Exception as e:
            logger.error('Unable to parse quantity for ingredient %s', label)
            logger.exception(e)
            raise ParserException(self.INGREDIENTS)

    def parse_duration(self, duration, field):
        m = re.match(r'^(?:(?P<days>[0-9]+)\s*j)?\s*(?:(?P<hours>[0-9]+)\s*h)?\s*(?:(?P<minutes>[0-9]+)(?:\s*m(?:in)?)?)?$', duration)

        if not m:
            raise ParserException(field)

        return (int(m.group('days')) * 24 * 60 if m.group('days') else 0) + \
               (int(m.group('hours')) * 60 if m.group('hours') else 0) + \
               (int(m.group('minutes')) if m.group('minutes') else 0)

    def parse_difficulty(self, difficulty):
        values = (
            ('très facile',),
            ('facile',),
            ('moyen', 'niveau moyen'),
            ('difficile',),
        )
        for difficulty_value, labels in enumerate(values):
            if difficulty.lower() in labels:
                return difficulty_value + 1
        logger.error('Unknown value "%s" for difficulty!', difficulty)
        raise ParserException('difficulty')

    def parse_cost(self, cost):
        values = (
            ('bon marché',),
            ('coût moyen',),
            ('assez cher',),
        )
        for cost_value, labels in enumerate(values):
            if cost.lower() in labels:
                return cost_value + 1
        logger.error('Unknown value "%s" for cost!', cost)
        raise ParserException('cost')

    def parse(self):
        html = self.fetch_html()
        dom = self.parse_dom(html)
        self.parse_content(dom)
        self.check_content()
        return self._result

    def parse_content(self, dom):
        pass

    def check_content(self):
        if not self._result[self.TITLE]:
            raise ParserException(self.TITLE)

        if not self._result[self.PERSONS]:
            raise ParserException(self.PERSONS)

        if not self._result[self.STEPS]:
            raise ParserException(self.STEPS)

    def __str__(self):
        return '{} (0x{:02X})'.format(
            self.__class__.__name__,
            id(self),
        )

from recipes.parsers.marmiton import MarmitonParser
