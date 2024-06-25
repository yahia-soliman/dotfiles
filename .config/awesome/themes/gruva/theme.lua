-- ░▀█▀░█░█░█▀▀░█▄█░█▀▀
-- ░░█░░█▀█░█▀▀░█░█░█▀▀
-- ░░▀░░▀░▀░▀▀▀░▀░▀░▀▀▀

local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local xrdb = xresources.get_current_theme()
local gears = require("gears")
local gfs = require("gears.filesystem")
local helpers = require("helpers")
local themes_path = gfs.get_themes_dir()
local theme = {}

-- ░█▀▀░█▀█░█▀█░▀█▀░█▀▀
-- ░█▀▀░█░█░█░█░░█░░▀▀█
-- ░▀░░░▀▀▀░▀░▀░░▀░░▀▀▀

theme.font_name = "monospace "
theme.font = theme.font_name .. "10"
theme.wibar_font = theme.font_name .. "Bold 10"
theme.icon_font_name = "monospace "
theme.wibar_icon_font = theme.font_name .. "12"

-- ░█▀▀░█▀█░█░░░█▀█░█▀▄░█▀▀
-- ░█░░░█░█░█░░░█░█░█▀▄░▀▀█
-- ░▀▀▀░▀▀▀░▀▀▀░▀▀▀░▀░▀░▀▀▀

-- Colors
theme.black		= xrdb.color0
theme.black_alt	= xrdb.color8
theme.red		= xrdb.color1
theme.darkred	= helpers.lighten(theme.red, -10)
theme.green		= xrdb.color2
theme.darkgreen = helpers.lighten(theme.green, -10)
theme.yellow	= xrdb.color3
theme.darkyellow = helpers.lighten(theme.yellow, -10)
theme.blue		= xrdb.color4
theme.darkblue	= helpers.lighten(theme.blue, -10)
theme.magenta	= xrdb.color5
theme.darkmagenta = helpers.lighten(theme.magenta, -10)
theme.cyan		= xrdb.color6
theme.darkcyan	= helpers.lighten(theme.cyan, -10)
theme.white		= xrdb.color7
theme.white_alt = xrdb.color15
theme.light_bg	= helpers.lighten(theme.black, 5)
theme.transparent = "#00000000"

-- Background Colors
theme.bg_normal = theme.black
theme.bg_focus = theme.blue
theme.bg_urgent = theme.red
theme.bg_minimize = theme.black

-- Foreground Colors
theme.fg_normal = theme.white
theme.fg_focus = theme.black
theme.fg_urgent = theme.white
theme.fg_minimize = theme.black_alt

--- ░█░█░▀█▀░░░█▀▀░█░░░█▀▀░█▄█░█▀▀░█▀█░▀█▀░█▀▀
--- ░█░█░░█░░░░█▀▀░█░░░█▀▀░█░█░█▀▀░█░█░░█░░▀▀█
--- ░▀▀▀░▀▀▀░░░▀▀▀░▀▀▀░▀▀▀░▀░▀░▀▀▀░▀░▀░░▀░░▀▀▀

-- Borders
-- ===================================================================
theme.border_width = dpi(3)
theme.border_normal = theme.light_bg
theme.border_focus = theme.yellow
theme.widget_border_color = theme.light_bg

-- Wibar
-- ===================================================================
theme.wibar_position = "top"
theme.wibar_height = dpi(25)
theme.wibar_width = dpi(1295)
theme.wibar_bg = theme.black
theme.wibar_fg = theme.white

-- Taglist
-- ===================================================================
theme.taglist_text_font = theme.wibar_ico_font
theme.taglist_text_empty	= { "", "", "", "", "", "" }
theme.taglist_text_occupied = { "", "", "", "", "", "" }
theme.taglist_text_focused	= { "", "", "", "", "", "" }
theme.taglist_text_urgent = { "", "", "", "", "", "" }

theme.taglist_text_color_empty = {
	theme.black_alt,
	theme.black_alt,
	theme.black_alt,
	theme.black_alt,
	theme.black_alt,
	theme.black_alt,
}
theme.taglist_text_color_occupied = {
	theme.green,
	theme.yellow,
	theme.blue,
	theme.red,
	theme.cyan,
	theme.magenta,
}
theme.taglist_text_color_focused = {
	theme.green,
	theme.yellow,
	theme.blue,
	theme.red,
	theme.cyan,
	theme.magenta,
}
theme.taglist_text_color_urgent = {
	theme.green,
	theme.yellow,
	theme.blue,
	theme.red,
	theme.cyan,
	theme.magenta,
}

-- Text Taglist (default)
theme.taglist_font = theme.wibar_font
theme.taglist_bg_focus = theme.wibar_bg
theme.taglist_fg_focus = theme.fg_focus
theme.taglist_bg_occupied = theme.wibar_bg
theme.taglist_fg_occupied = theme.fg_normal
theme.taglist_bg_empty = theme.wibar_bg
theme.taglist_fg_empty = theme.black_alt
theme.taglist_bg_urgent = theme.wibar_bg
theme.taglist_fg_urgent = theme.fg_urgent
theme.taglist_disable_icon = true
theme.taglist_spacing = dpi(0)
local taglist_square_size = dpi(0)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(taglist_square_size, theme.fg_focus)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(taglist_square_size, theme.fg_normal)

-- Tasklist
-- ===================================================================
theme.tasklist_font = theme.font
theme.tasklist_disable_icon = false
theme.tasklist_plain_task_name = false
theme.tasklist_bg_focus = theme.darkyellow
theme.tasklist_fg_focus = theme.fg_normal
theme.tasklist_bg_normal = theme.wibar_bg
theme.tasklist_fg_normal = theme.black_alt
theme.tasklist_bg_minimize = theme.bg_minimize
theme.tasklist_fg_minimize = theme.fg_minimize
theme.tasklist_bg_urgent = theme.bg_urgent
theme.tasklist_fg_urgent = theme.fg_urgent
theme.tasklist_align = "center"

--- Titlebar
-- ===================================================================
theme.titlebars_enabled = false
theme.titlebar_size = dpi(22)
theme.titlebar_title_enabled = true
theme.titlebar_font = theme.font
theme.titlebar_title_align = "right"
theme.titlebar_position = "top"
theme.titlebar_bg = theme.bg_normal
-- theme.titlebar_bg_focus = theme.bg_focus
-- theme.titlebar_bg_normal = theme.bg_normal
-- theme.titlebar_fg = theme.fg_normal
-- theme.titlebar_fg_focus = theme.fg_focus
-- theme.titlebar_fg_normal = theme.fg_normal

-- Menu
-- Variables set for theming the menu:
-- ===================================================================
theme.menu_height = dpi(30)
theme.menu_width = dpi(150)
theme.menu_bg_normal = theme.bg_normal
theme.menu_fg_normal = theme.fg_normal
theme.menu_bg_focus = theme.bg_focus
theme.menu_fg_focus = theme.fg_focus
theme.menu_border_width = theme.widget_border_width
theme.menu_border_color = theme.widget_border_color

-- Gaps
-- ===================================================================
theme.useless_gap = dpi(6)
theme.screen_margin = dpi(3)

-- Systray
-- ===================================================================
theme.bg_systray = theme.wibar_bg


-- Layout icons
-- ===================================================================
theme.layout_max = themes_path .. "default/layouts/maxw.png"
theme.layout_tile = themes_path .. "default/layouts/tilew.png"
theme.layout_floating = themes_path .. "default/layouts/floatingw.png"
-- not in use layouts
theme.layout_cornernw = themes_path .. "default/layouts/cornernww.png"
theme.layout_cornerne = themes_path .. "default/layouts/cornernew.png"
theme.layout_cornersw = themes_path .. "default/layouts/cornersww.png"
theme.layout_cornerse = themes_path .. "default/layouts/cornersew.png"
theme.layout_fairh = themes_path .. "default/layouts/fairhw.png"
theme.layout_fairv = themes_path .. "default/layouts/fairvw.png"
theme.layout_magnifier = themes_path .. "default/layouts/magnifierw.png"
theme.layout_fullscreen = themes_path .. "default/layouts/fullscreenw.png"
theme.layout_spiral = themes_path .. "default/layouts/spiralw.png"
theme.layout_dwindle = themes_path .. "default/layouts/dwindlew.png"
theme.layout_tiletop = themes_path .. "default/layouts/tiletopw.png"
theme.layout_tilebottom = themes_path .. "default/layouts/tilebottomw.png"
theme.layout_tileleft = themes_path .. "default/layouts/tileleftw.png"
-- Recolor layout icons
theme = theme_assets.recolor_layout(theme, theme.red)
-- Layoutlist
theme.layoutlist_shape_selected = gears.shape.rounded_rect
theme.layoutlist_bg_selected = theme.bg_focus

-- Misc
-- ===================================================================
-- Edge snap
theme.snap_bg = theme.light_bg
theme.snap_shape = helpers.rrect(theme.border_radius)
theme.snap_border_width = theme.widget_border_width

-- Hotkeys popup
theme.hotkeys_modifiers_fg = theme.blue

-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(theme.menu_height, theme.bg_focus, theme.fg_focus)
-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

return theme
-- EOF ------------------------------------------------------------------------
