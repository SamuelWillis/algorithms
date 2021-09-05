import unittest

from python_impl import sorting


class TestSorting(unittest.TestCase):
    def test_insertion_sort(self):
        unsorted_list = [5, 4, 3, 2, 1]

        sorted_list = unsorted_list.copy()
        sorted_list.sort()


        self.assertEqual(sorting.insertion_sort(unsorted_list), sorted_list)

if __name__ == '__main__':
    unittest.main()
