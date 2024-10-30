#!/usr/bin/python

from datetime import datetime

import whensies


def useful_assert(expected: str, actual: str):
    try:
        assert actual == expected
    except AssertionError:
        print(actual + ' vs ' + expected)


print('day')
test_date = datetime.date(datetime(2024, 3, 31))
actual_lines = whensies.check_lines(
    [
        '31 before',
        '1 after',
    ],
    test_date,
)
print(actual_lines)

print('month')
test_date = datetime.date(datetime(2024, 12, 31))
actual_lines = whensies.check_lines(
    [
        '12.31 before',
        '1.1 after',
    ],
    test_date,
)
print(actual_lines)

print('year')
test_date = datetime.date(datetime(2024, 12, 31))
actual_lines = whensies.check_lines(
    [
        '24.12.31 before',
        '25.1.1 after',
    ],
    test_date,
)
print(actual_lines)
