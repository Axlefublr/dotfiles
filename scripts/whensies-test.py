#!/usr/bin/python

from datetime import datetime

import whensies


def useful_assert(expected: str, actual: str):
    try:
        assert actual == expected
    except AssertionError:
        print(actual + ' vs ' + expected)


test_date = datetime.date(datetime(2024, 3, 30))

actual_lines, _ = whensies.check_file(
    '/home/axlefublr/prog/dotfiles/scripts/whensies-test-data.txt', test_date
)

useful_assert('tomorrow only day, this month', actual_lines[0])
useful_assert('today only day, today, this month', actual_lines[1])
