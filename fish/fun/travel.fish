#!/usr/bin/env fish

function paste_ranger_file
	ranger --choosefile /tmp/flickie
	commandline -i (cat /tmp/flickie)
end
funcsave paste_ranger_file > /dev/null

function paste_ranger_dir
	ranger --choosedir /tmp/dickie
	commandline -i (cat /tmp/dickie)
end
funcsave paste_ranger_dir > /dev/null