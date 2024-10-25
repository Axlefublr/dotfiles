#!/usr/bin/python

import datetime


def parse_date(date: str, assume_today: datetime.date):
    try:
        parsed_date = datetime.datetime.strptime(date, '%y.%m.%d').date()
    except ValueError:
        today = assume_today
        this_year = today.year
        this_month = today.month
        try:
            parsed_date = datetime.datetime.strptime(f'{this_year}.{date}', '%Y.%m.%d').date()
        except ValueError:
            try:
                parsed_date = datetime.datetime.strptime(
                    f'{this_year}.{this_month}.{date}', '%Y.%m.%d'
                ).date()
            except ValueError:
                return None
    return parsed_date


def check_file(file_path: str, against: datetime.date):
    lines_to_keep: list[str] = []
    lines_to_print: list[str] = []
    today = against
    tomorrow = today + datetime.timedelta(days=1)

    with open(file_path) as file:
        lines = file.readlines()

    for line in lines:
        elements = line.split(' ')
        maybe_date = elements[0]
        rest = elements[1:]
        event_name = ' '.join(rest)

        event_date = parse_date(maybe_date, today)
        if event_date is None:
            lines_to_keep.append(line)
            continue

        if event_date == today:
            lines_to_print.append(f'today {event_name.rstrip()}')
        elif event_date == tomorrow:
            lines_to_print.append(f'tomorrow {event_name.rstrip()}')
            lines_to_keep.append(line)
        elif event_date > tomorrow:
            lines_to_keep.append(line)

    return lines_to_print, lines_to_keep


if __name__ == '__main__':
    file_path = '/home/axlefublr/.local/share/magazine/T'
    today = datetime.datetime.today()
    lines_to_print, lines_to_keep = check_file(file_path, today)
    print('\n'.join(lines_to_print))
    with open(file_path, 'w') as file:
        file.writelines(lines_to_keep)
