#!/usr/bin/python

import datetime

file_path = "/home/axlefublr/.local/share/magazine/T"

today = datetime.date.today()
tomorrow = today + datetime.timedelta(days=1)

date_format = "%y.%m.%d"

lines_to_keep = []

with open(file_path, "r") as file:
    lines = file.readlines()

for line in lines:
    try:
        event_date_str = line.split(" ")[0]
        event_date = datetime.datetime.strptime(event_date_str, date_format).date()
        event_name = line[9:].rstrip()

        if event_date == today:
            print(f"today at {event_name}")
        elif event_date == tomorrow:
            print(f"tomorrow at {event_name}")
            lines_to_keep.append(line)
        elif event_date > tomorrow:
            lines_to_keep.append(line)
    except ValueError:
        continue

with open(file_path, "w") as file:
    file.writelines(lines_to_keep)
