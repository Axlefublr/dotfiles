swayimg.decoration = false
swayimg.dnd_button = 'MouseRight'
swayimg.mode = 'viewer'
-- [[sort on]]
swayimg.gallery.aspect = 'fit'
swayimg.gallery.border_color = 0xffffd75f
swayimg.gallery.border_size = 2
swayimg.gallery.padding_size = 0
swayimg.gallery.preload = true
swayimg.gallery.pstore = true
swayimg.gallery.selected_color = 0xd8282828
swayimg.gallery.selected_scale = 1.30
swayimg.gallery.text = { bottomleft = { '{list.index}/{list.total}' }  }
swayimg.gallery.text = { topleft = { '{name}' }  }
swayimg.gallery.text = { topright = {}  }
swayimg.gallery.thumb_size = 240
swayimg.gallery.unselected_color = 0xd8282828
swayimg.gallery.window_color = 0xd8282828
swayimg.imagelist.adjacent = true
swayimg.imagelist.order = 'mtime'
swayimg.imagelist.reverse = true
swayimg.text.background = 0xff1f1e1e
swayimg.text.color = 0xffd4be98
swayimg.text.font = 'Inter'
swayimg.text.shadow = 0x00000000
swayimg.text.size = 18
swayimg.text.status_timeout = 3
swayimg.text.timeout = 0
swayimg.viewer.default_scale = 'fit'
swayimg.viewer.history = 5
swayimg.viewer.preload = 5
swayimg.viewer.set_image_background(0xd8282828)
swayimg.viewer.set_window_background(0xd8282828)
swayimg.viewer.text = { bottomleft = { '{scale}', '{list.index}/{list.total}' } }
swayimg.viewer.text = { topleft = { '{name}', '{frame.width}x{frame.height}', '{sizehr}', '{format}' } }
swayimg.viewer.text = { topright = {} }
-- [[sort off]]
swayimg.text.visible = false

for _, section in ipairs({ 'gallery', 'viewer' }) do
	-- [[sort on]]
	swayimg[section].on_key('Ctrl+End', function() swayimg[section].switch_image('last') end)
	swayimg[section].on_key('Ctrl+Home', function() swayimg[section].switch_image('first') end)
	swayimg[section].on_key('Shift+i', function() os.execute(string.format("si.fish %q", swayimg[section].get_image().path)) end)
	swayimg[section].on_key('c', function() swayimg.imagelist.remove(swayimg[section].get_image().path) end)
	swayimg[section].on_key('d', function() local path = swayimg[section].get_image().path  os.execute(string.format("trash-put %q", path))  swayimg.imagelist.remove(path) end)
	swayimg[section].on_key('i', function() os.execute(string.format("sl.fish %q", swayimg[section].get_image().path)) end)
	swayimg[section].on_key('s', function() os.execute(string.format("fish -c 'echo %q | wl-copy -nt text/plain'", swayimg[section].get_image().path)) end)
	swayimg[section].on_key('v', function() swayimg.fullscreen = true end)
	swayimg[section].on_key('x', function() swayimg.text.visible = not swayimg.text.visible end)
	-- [[sort off]]
	swayimg[section].on_key('g', function()
		local path = swayimg[section].get_image().path
		local fish_command = string.format('niri msg action spawn -- footclient -NT swayimg-(path basename (path dirname %q)) yazi %q', path, path)
		os.execute(string.format('fish -c %q', fish_command))
		swayimg.exit()
	end)
end

-- [[sort on]]
swayimg.gallery.on_key('h', function() swayimg.gallery.switch_image('left') end)
swayimg.gallery.on_key('j', function() swayimg.gallery.switch_image('down') end)
swayimg.gallery.on_key('k', function() swayimg.gallery.switch_image('up') end)
swayimg.gallery.on_key('l', function() swayimg.gallery.switch_image('right') end)
swayimg.viewer.on_key('a', function() swayimg.viewer.set_fix_scale('fit') end)
swayimg.viewer.on_key('f', function() swayimg.viewer.set_fix_scale('fill') end)
swayimg.viewer.on_key('h', function() swayimg.viewer.switch_image('prev') end)
swayimg.viewer.on_key('l', function() swayimg.viewer.switch_image('next') end)
swayimg.viewer.on_key('n', function() swayimg.viewer.animation = not swayimg.viewer.animation end)
swayimg.viewer.on_key('r', function() swayimg.viewer.switch_image('random') end)
swayimg.viewer.on_key('s', function() swayimg.viewer.reset() end)
swayimg.viewer.on_key('t', function() swayimg.viewer.set_fix_scale('optimal') end)
-- [[sort off]]

swayimg.on_window_resize(function()
	if swayimg.mode == 'viewer' then
		swayimg.viewer.reset()
	end
end)

swayimg.on_initialized(function()
	if swayimg.mode == 'viewer' and FLOATING then
		local current_image = swayimg.viewer.get_image()
		swayimg.set_window_size(current_image.width, current_image.height)
	end
end)
