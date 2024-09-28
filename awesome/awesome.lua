awm = {}
env = {}

awm.gears = require('gears')
awful = require('awful')
wibox = require('wibox')
beautiful = require('beautiful')
naughty = require('naughty')
menubar = require('menubar')

-- change the focused window on various useful events automatically
-- god knows what those are!
require('awful.autofocus')

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
	naughty.notify({
		preset = naughty.config.presets.critical,
		title = 'Oops, there were errors during startup!',
		text = awesome.startup_errors,
	})
end

-- Handle runtime errors after startup
do
	local in_error = false
	awesome.connect_signal('debug::error', function(err)
		-- Make sure we don't go into an endless error loop
		if in_error then return end
		in_error = true

		naughty.notify({
			preset = naughty.config.presets.critical,
			title = 'Oops, an error happened!',
			text = tostring(err),
		})
		in_error = false
	end)
end
-- }}}

beautiful.init('/home/axlefublr/.config/awesome/theme.lua')
beautiful.gap_single_client = true

naughty.config.defaults.position = 'bottom_right'
naughty.config.presets.critical.bg = beautiful.darkerest
naughty.config.presets.critical.fg = beautiful.red

terminal = 'kitty'
editor = os.getenv('EDITOR') or 'nano'
editor_cmd = terminal .. ' -e ' .. editor
modkey = 'Mod4'

require('global')
require('layouts')
require('screen')
require('keys')
require('rules')
require('signals')

function Trim_newlines(string)
	string = string:gsub('[\r\n]*$', '')
	return string:gsub('^[\r\n]*', '')
end

awful.spawn.once('/home/axlefublr/prog/dotfiles/scripts/setup/login.fish', {})
