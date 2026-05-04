swayimg.enable_decoration(false)
swayimg.set_dnd_button('MouseRight')
swayimg.set_mode('viewer')
-- [[sort on]]
swayimg.gallery.enable_preload(true)
swayimg.gallery.enable_pstore(true)
swayimg.gallery.set_aspect('fit')
swayimg.gallery.set_border_color(0xffffd75f)
swayimg.gallery.set_border_size(2)
swayimg.gallery.set_padding_size(0)
swayimg.gallery.set_selected_color(0xee282828)
swayimg.gallery.set_selected_scale(1.30)
swayimg.gallery.set_text('bottomleft', { '{list.index}/{list.total}' })
swayimg.gallery.set_text('topleft', { '{name}' })
swayimg.gallery.set_text('topright', {})
swayimg.gallery.set_thumb_size(240)
swayimg.gallery.set_unselected_color(0xee282828)
swayimg.gallery.set_window_color(0xee282828)
swayimg.imagelist.enable_adjacent(true)
swayimg.imagelist.enable_reverse(true)
swayimg.imagelist.set_order('mtime')
swayimg.text.set_background(0xff1f1e1e)
swayimg.text.set_font('Inter')
swayimg.text.set_foreground(0xffd4be98)
swayimg.text.set_shadow(0x00000000)
swayimg.text.set_size(18)
swayimg.text.set_status_timeout(3)
swayimg.text.set_timeout(0)
swayimg.viewer.limit_history(5)
swayimg.viewer.limit_preload(5)
swayimg.viewer.set_default_scale('fit')
swayimg.viewer.set_image_background(0xee282828)
swayimg.viewer.set_text('bottomleft', { '{scale}', '{list.index}/{list.total}' })
swayimg.viewer.set_text('topleft', { '{name}', '{frame.width}x{frame.height}', '{sizehr}', '{format}' })
swayimg.viewer.set_text('topright', {})
swayimg.viewer.set_window_background(0xee282828)
-- [[sort off]]
swayimg.text.hide()

for _, section in ipairs({ 'gallery', 'viewer' }) do
	-- [[sort on]]
	swayimg[section].on_key('Ctrl+End', function() swayimg[section].switch_image('last') end)
	swayimg[section].on_key('Ctrl+Home', function() swayimg[section].switch_image('first') end)
	swayimg[section].on_key('Shift+i', function() os.execute(string.format("si.fish %q", swayimg[section].get_image().path)) end)
	swayimg[section].on_key('c', function() swayimg.imagelist.remove(swayimg[section].get_image().path) end)
	swayimg[section].on_key('d', function() local path = swayimg[section].get_image().path  os.execute(string.format("trash-put %q", path))  swayimg.imagelist.remove(path) end)
	swayimg[section].on_key('i', function() os.execute(string.format("sl.fish %q", swayimg[section].get_image().path)) end)
	swayimg[section].on_key('s', function() os.execute(string.format("fish -c 'echo %q | wl-copy -n'", swayimg[section].get_image().path)) end)
	swayimg[section].on_key('v', function() swayimg.set_fullscreen() end)
	swayimg[section].on_key('x', function() if swayimg.text.visible() then swayimg.text.hide() else swayimg.text.show() end end)
	-- [[sort off]]
end

-- [[sort on]]
swayimg.viewer.on_key('a', function() swayimg.viewer.set_fix_scale('fit') end)
swayimg.viewer.on_key('f', function() swayimg.viewer.set_fix_scale('fill') end)
swayimg.viewer.on_key('h', function() swayimg.viewer.switch_image('prev') end)
swayimg.viewer.on_key('l', function() swayimg.viewer.switch_image('next') end)
swayimg.viewer.on_key('n', function() swayimg.viewer.set_animation() end)
swayimg.viewer.on_key('r', function() swayimg.viewer.switch_image('random') end)
swayimg.viewer.on_key('t', function() swayimg.viewer.set_fix_scale('optimal') end)
-- [[sort off]]

swayimg.on_window_resize(function()
	if swayimg.get_mode() == 'viewer' then
		swayimg.viewer.set_fix_scale('fit')
	end
end)

swayimg.on_initialized(function()
	if swayimg.get_mode() == 'viewer' and FLOATING then
		local current_image = swayimg.viewer.get_image()
		swayimg.set_window_size(current_image.width, current_image.height)
	end
end)
