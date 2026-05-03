swayimg.set_mode('viewer')
swayimg.enable_decoration(false)
swayimg.set_dnd_button('MouseRight')
swayimg.imagelist.set_order('mtime')
swayimg.imagelist.enable_reverse(true)
swayimg.imagelist.enable_adjacent(true)
swayimg.text.set_font('Inter')
swayimg.text.set_size(18)
swayimg.text.set_foreground(0xffd4be98)
swayimg.text.set_background(0xff1f1e1e)
swayimg.text.set_shadow(0x00000000)
swayimg.text.set_timeout(0)
swayimg.text.set_status_timeout(0)
swayimg.viewer.set_default_scale('fit')
swayimg.viewer.set_window_background(0xee282828)
swayimg.viewer.set_image_background(0xee282828)
swayimg.viewer.limit_preload(5)
swayimg.viewer.limit_history(5)
swayimg.viewer.set_text('topleft', {
  '{name}',
  '{frame.width}x{frame.height}',
  '{sizehr}',
  '{format}',
})
swayimg.viewer.set_text('topright', {})
swayimg.viewer.set_text('bottomleft', {
  '{scale}',
  '{list.index}/{list.total}',
})
swayimg.gallery.set_text('topleft', {
  '{name}',
})
swayimg.gallery.set_text('topright', {})
swayimg.gallery.set_text('bottomleft', {
  '{list.index}/{list.total}',
})
