import tempfile
from cooking_assistant import read_config
from cooking_assistant.exceptions import ConfigurationException
from tests.unit import UnitTestCase
from unittest.mock import MagicMock, patch


class ConfigUnitTest(UnitTestCase):
    def test_read_config_with_directory(self):
        with self.assertRaises(ConfigurationException) as ctx:
            with tempfile.TemporaryDirectory() as tmp_dir:
                read_config(tmp_dir)

    def test_read_config_with_reading_error(self):
        with self.assertRaises(ConfigurationException) as ctx:
            with tempfile.NamedTemporaryFile() as f:
                with patch('builtins.open') as mock_open:
                    mock_open.side_effect = IOError
                    read_config(f.name)
