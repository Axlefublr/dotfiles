#!/usr/bin/python

import datetime

file_path = "/home/axlefublr/.local/share/magazine/T"

today = datetime.date.today()
tomorrow = today + datetime.timedelta(days=1)

def triple_parse(date):
    try:
        parsed_date = datetime.datetime.strptime(date, "%y.%m.%d").date()
    except ValueError:
        today = datetime.datetime.today()
        this_year = today.year
        this_month = today.month
        try:
            parsed_date = datetime.datetime.strptime(f"{this_year}.{date}", "%Y.%m.%d").date()
        except ValueError:
            try:
                parsed_date = datetime.datetime.strptime(f"{this_year}.{this_month}.{date}", "%Y.%m.%d").date()
            except ValueError:
                return None
    return parsed_date

lines_to_keep = []

with open(file_path, "r") as file:
    lines = file.readlines()

for line in lines:
    elements = line.split(" ")
    maybe_date = elements[0]
    rest = elements[1:]
    event_name = " ".join(rest)

    event_date = triple_parse(maybe_date)
    if event_date is None:
        lines_to_keep.append(line)
        continue

    if event_date == today:
        print(f"today {event_name.rstrip()}")
    elif event_date == tomorrow:
        print(f"tomorrow {event_name.rstrip()}")
        lines_to_keep.append(line)
    elif event_date > tomorrow:
        lines_to_keep.append(line)

with open(file_path, "w") as file:
    file.writelines(lines_to_keep)
