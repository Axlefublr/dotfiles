#!/usr/bin/env fish

function ansi_cursor_move_home -d 'to position 0,0'
    echo -en '\e[H'
end
funcsave ansi_cursor_move_home >/dev/null

function ansi_cursor_move_up -a lines
    not test "$lines" && set -f lines 1
    echo -en '\e['$lines'A'
end
funcsave ansi_cursor_move_up >/dev/null

function ansi_cursor_move_start_up -a lines
    not test "$lines" && set -f lines 1
    echo -en '\e['$lines'F'
end
funcsave ansi_cursor_move_start_up >/dev/null

function ansi_cursor_move_start_down -a lines
    not test "$lines" && set -f lines 1
    echo -en '\e['$lines'E'
end
funcsave ansi_cursor_move_start_down >/dev/null

function ansi_cursor_hide
    echo -en '\e[?25l'
end
funcsave ansi_cursor_hide >/dev/null

function ansi_cursor_show
    echo -en '\e[?25h'
end
funcsave ansi_cursor_show >/dev/null

function ansi_erase_line
    echo -en '\e[2K'
end
funcsave ansi_erase_line >/dev/null
