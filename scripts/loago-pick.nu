#!/usr/bin/env nu

loago list |
parse -r '(?P<title>\w+)\s+—\s+(?P<days>\d+)' |
get title |
where $it != eat |
to text |
fuzzel -d --cache ~/.cache/mine/loago-pick |
each { |$thingy|
  loago do ($thingy | str trim)
}
