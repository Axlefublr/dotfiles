#!/usr/bin/env fish

function is-internet
	set -l response (nmcli networking connectivity)
	if test $response = 'full'
		return 0
	else if test $response = 'none'
		return 1
	else if test $response = 'limited'
		return 1
	else
		echo "unexpected response ($response) from `nmcli networking connectivity`" &> /dev/stderr
		return 1
	end
end
funcsave is-internet > /dev/null

function wm-rotate
	qdbus org.kde.kglobalaccel /component/bismuth invokeShortcut rotate
end
funcsave wm-rotate > /dev/null

function wm-float
	qdbus org.kde.kglobalaccel /component/bismuth invokeShortcut toggle_window_floating
end
funcsave wm-float > /dev/null

function wm-increase-window-width
	qdbus org.kde.kglobalaccel /component/bismuth invokeShortcut increase_window_width
end
funcsave wm-increase-window-width > /dev/null

function wm-increase-master-window-size
	qdbus org.kde.kglobalaccel /component/bismuth invokeShortcut increase_master_size
end
funcsave wm-increase-master-window-size > /dev/null

function wm-layout-quarter
	qdbus org.kde.kglobalaccel /component/bismuth invokeShortcut toggle_quarter_layout
end
funcsave wm-layout-quarter > /dev/null

function wm-decrease-master-windows
	qdbus org.kde.kglobalaccel /component/bismuth invokeShortcut decrease_master_win_count
end
funcsave wm-decrease-master-windows > /dev/null