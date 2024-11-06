#!/usr/bin/env fish

begin
    echo -n https://www.youtube.com/watch?v=
    string match -gr ';(.*);' "$argv"
end | copy
