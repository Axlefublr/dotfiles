#!/usr/bin/python

import datetime
from typing import List


def parse_date(date: str, assume_today: datetime.date):
    try:
        parsed_date = datetime.datetime.strptime(date, '%y.%m.%d').date()
    except ValueError:
        today = assume_today
        this_year = today.year
        this_month = today.month

        try:
            parsed_date = datetime.datetime.strptime(f'{this_year}.{this_month}.{date}', '%Y.%m.%d').date()

            if parsed_date < today:
                if this_month == 12:
                    parsed_date = parsed_date.replace(year=this_year + 1, month=1)
                else:
                    parsed_date = parsed_date.replace(month=this_month + 1)

        except ValueError:
            try:
                parsed_date = datetime.datetime.strptime(f'{this_year}.{date}', '%Y.%m.%d').date()

                if parsed_date < today and today.month == 12 and today.day == 31:
                    parsed_date = parsed_date.replace(year=this_year + 1)

            except ValueError:
                return None
    return parsed_date


def check_lines(lines: List[str], against: datetime.date):
    lines_to_print: list[str] = []
    today = against
    tomorrow = today + datetime.timedelta(days=1)

    for line in lines:
        elements = line.split(' ')
        maybe_date = elements[0]
        rest = elements[1:]
        event_name = ' '.join(rest)

        event_date = parse_date(maybe_date, today)
        if event_date is None:
            continue

        if event_date == today:
            lines_to_print.append(f'today {event_name.rstrip()}')
        elif event_date == tomorrow:
            lines_to_print.append(f'tomorrow {event_name.rstrip()}')

    return lines_to_print


if __name__ == '__main__':
    file_path = '/home/axlefublr/.local/share/magazine/T'
    today = datetime.date.today()
    with open(file_path) as file:
        lines = file.readlines()
    lines_to_print = check_lines(lines, today)
    print('\n'.join(lines_to_print))
