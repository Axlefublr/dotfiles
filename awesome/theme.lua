---------------------------
-- Default awesome theme --
---------------------------

local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local gfs = require("gears.filesystem")
local themes_path = gfs.get_themes_dir()

local theme = {}

theme.font          = "Ubuntu NF 12"
theme.code_font     = "JetBrainsMonoNL NF 12"
theme.background    = "#292828"
theme.white         = "#d4be98"
theme.darkerest     = "#212121"
theme.lighter       = "#313030"
theme.pink          = "#ffafd7"
theme.yellow        = "#ffd75f"
theme.black         = "#0f0f0f"
theme.red           = "#ff2930"
theme.cyan          = "#00d7ff"
theme.green         = "#87ff5f"

theme.bg_normal     = theme.background
theme.bg_focus      = theme.darkerest
theme.bg_urgent     = theme.pink
theme.bg_minimize   = theme.lighter
theme.bg_systray    = theme.bg_normal

theme.fg_normal     = theme.white
theme.fg_focus      = theme.white
theme.fg_urgent     = theme.black
theme.fg_minimize   = theme.white

theme.useless_gap   = dpi(5)
theme.border_width  = dpi(2)
theme.border_normal = theme.background
theme.border_focus  = theme.yellow
theme.border_marked = theme.pink

theme.prompt_font = theme.code_font

theme.taglist_fg_focus = theme.black
theme.taglist_bg_focus = theme.yellow
theme.taglist_font     = theme.code_font

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]
-- tasklist_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- prompt_[fg|bg|fg_cursor|bg_cursor|font]
-- hotkeys_[bg|fg|border_width|border_color|shape|opacity|modifiers_fg|label_bg|label_fg|group_margin|font|description_font]
-- Example:
--theme.taglist_bg_focus = "#ff0000"

-- Variables set for theming notifications:
theme.notification_font = "Ubuntu NF 16"
theme.notification_code_font = "JetBrainsMonoNL NF 16"
theme.notification_bg = theme.darkerest
theme.notification_border_color = theme.border_focus
-- notification_[width|height|margin]
-- notification_[border_color|border_width|shape|opacity]

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = themes_path.."default/submenu.png"
theme.menu_height = dpi(15)
theme.menu_width  = dpi(100)

theme.wallpaper = "/home/axlefublr/Pictures/tree/themes/deer.jpg"

theme.layout_icon_path = '/home/axlefublr/Pictures/tree/logos/awesome-layouts/'

theme.layout_fairh      = theme.layout_icon_path .. 'fairhw.png'
theme.layout_fairv      = theme.layout_icon_path .. 'fairvw.png'
theme.layout_max        = theme.layout_icon_path .. 'maxw.png'
theme.layout_tilebottom = theme.layout_icon_path .. 'tilebottomw.png'
theme.layout_tileleft   = theme.layout_icon_path .. 'tileleftw.png'
theme.layout_tile       = theme.layout_icon_path .. 'tilew.png'
theme.layout_tiletop    = theme.layout_icon_path .. 'tiletopw.png'
theme.layout_cornernw   = theme.layout_icon_path .. 'cornernww.png'
theme.layout_cornerne   = theme.layout_icon_path .. 'cornernew.png'
theme.layout_cornersw   = theme.layout_icon_path .. 'cornersww.png'
theme.layout_cornerse   = theme.layout_icon_path .. 'cornersew.png'

theme.layout_floating  = themes_path.."default/layouts/floatingw.png"
theme.layout_magnifier = themes_path.."default/layouts/magnifierw.png"
theme.layout_fullscreen = themes_path.."default/layouts/fullscreenw.png"
theme.layout_spiral  = themes_path.."default/layouts/spiralw.png"
theme.layout_dwindle = themes_path.."default/layouts/dwindlew.png"

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = 'Tela circle black dark'

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
