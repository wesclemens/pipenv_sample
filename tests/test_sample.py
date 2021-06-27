"""TESTING."""
import unittest

import sample


class TestDouble(unittest.TestCase):
    """Test Double."""

    def test_double(self):
        """TEST double."""
        self.assertEqual(sample.double(2), 4)
