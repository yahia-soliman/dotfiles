-- ░█▄█░█▀█░█▀▄░█▀▀░█▀▀░█▀█░█▀█░█▀█░▀█▀░▀░█▀▀░░░█▀█░█░█░█▀▀░█▀▀░█▀█░█▄█░█▀▀
-- ░█░█░█░█░█▀▄░▀▀█░█▀▀░█░█░█▀█░█▀▀░░█░░░░▀▀█░░░█▀█░█▄█░█▀▀░▀▀█░█░█░█░█░█▀▀
-- ░▀░▀░▀▀▀░▀▀░░▀▀▀░▀▀▀░▀░▀░▀░▀░▀░░░▀▀▀░░░▀▀▀░░░▀░▀░▀░▀░▀▀▀░▀▀▀░▀▀▀░▀░▀░▀▀▀

-- >> The file that binds everything together.
local awesome = awesome
local client = client
local screen = screen
local decorations = {}

-- User variables and preferences
-- ===================================================================
user = {
	terminal = "alacritty",
	floating_terminal = "alacritty --class floating_terminal",
	scratchpad_terminal = "alacritty -T ScratchPad --class scratchpad",
	editor = "alacritty --class editor -T neovim -e nvim",
	browser = "firefox",
	file_manager = "pcmanfm",
	app_launcher = "rofi -matching fuzzy -show drun",
}

-- Initialization
-- ===================================================================
local beautiful = require("beautiful")
-- Make dpi function global
dpi = beautiful.xresources.apply_dpi

-- Load AwesomeWM libraries
local gears = require("gears")
local gfs = require("gears.filesystem")
local awful = require("awful")
require("awful.autofocus")
-- Default notification library
-- local naughty = require("naughty")

-- Load theme
beautiful.init(gfs.get_configuration_dir() .. "themes/gruva/" .. "theme.lua")

-- Error handling
--[[ ===================================================================
naughty.connect_signal("request::display_error", function(message, startup)
	naughty.notification({
		urgency = "critical",
		title = "Oops, an error happened" .. (startup and " during startup!" or "!"),
		message = message,
	})
end)
naughty.resume()
]]--

-- Features
-- ===================================================================
-- Load helper functions
local helpers = require("helpers")
-- Apps
apps = {
	-- TODO: switchtotag not working?
	browser = function()
		awful.spawn(user.browser, { switchtotag = true })
	end,
	file_manager = function()
		awful.spawn(user.file_manager, { floating = true })
	end,
	editor = function()
		helpers.run_or_raise({ instance = "editor" }, false, user.editor, { switchtotag = true })
	end,
	volume = function()
		helpers.run_or_raise({ class = "Pavucontrol" }, true, "pavucontrol")
	end,
	process_monitor = function()
		helpers.run_or_raise(
			{ instance = "bottom" },
			false,
			user.terminal .. " --class bottom -e btm",
			{ switchtotag = true }
		)
	end,
	screenshot_full = function()
		awful.spawn.with_shell("maim -s | swappy -f -")
	end,
	screenshot_clipboard = function()
		awful.spawn.with_shell("maim -s | xclip -selection clipboard -t image/png")
	end,
	clipboard = function()
		awful.spawn.with_shell("CM_LAUNCHER='rofi' clipmenu")
	end,
	emoji_picker = function()
		awful.spawn("rofi -show emoji")
	end,
}

-- Confuguration folder
require("themes/gruva")

-- Keybinds and mousebinds
local keys = require("keys")

-- Window switcher
require("modules.window_switcher")
-- Notification center
-- require("modules.notification_center")

-- Daemons
-- Most widgets that display system/external info depend on evil.
-- Make sure to initialize it last in order to allow all widgets to connect to
-- their needed evil signals.
require("evil")

-- Get screen geometry
-- I am using a single screen setup and I assume that screen geometry will not
-- change during the session.
local screen_width = awful.screen.focused().geometry.width
local screen_height = awful.screen.focused().geometry.height

-- Layouts
-- ===================================================================
-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
	awful.layout.suit.tile,
	awful.layout.suit.floating,
	awful.layout.suit.max,
}


-- Tags
-- ===================================================================
awful.screen.connect_for_each_screen(function(s)
	-- Each screen has its own tag table.
	local l = awful.layout.suit -- Alias to save time :)
	-- Tag layouts
	local layouts = {
		l.max,
		l.max,
		l.max,
		l.tile,
		l.tile,
		l.tile,
	}

	-- Tag names
	local tagnames = beautiful.tagnames or { "1", "2", "3", "4", "5", "6" }
	-- Create all tags at once (without seperate configuration for each tag)
	awful.tag(tagnames, s, layouts)

end)

-- Determines how floating clients should be placed
local floating_client_placement = function(c)
	-- If the layout is floating or there are no other visible
	-- clients, center client
	if awful.layout.get(mouse.screen) ~= awful.layout.suit.floating or #mouse.screen.clients == 1 then
		return awful.placement.centered(c, { honor_padding = true, honor_workarea = true })
	end

	-- Else use this placement
	local p = awful.placement.no_overlap + awful.placement.no_offscreen
	return p(c, { honor_padding = true, honor_workarea = true, margins = beautiful.useless_gap * 2 })
end

local centered_client_placement = function(c)
	return gears.timer.delayed_call(function()
		awful.placement.centered(c, { honor_padding = true, honor_workarea = true })
	end)
end

-- Rules
-- ===================================================================
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
	{
		-- All clients will match this rule.
		rule = {},
		properties = {
			border_width = beautiful.border_width,
			border_color = beautiful.border_normal,
			focus = awful.client.focus.filter,
			raise = true,
			keys = keys.clientkeys,
			buttons = keys.clientbuttons,
			screen = awful.screen.focused,
			size_hints_honor = false,
			honor_workarea = true,
			honor_padding = true,
			maximized = false,
			titlebars_enabled = beautiful.titlebars_enabled,
			maximized_horizontal = false,
			maximized_vertical = false,
			placement = floating_client_placement,
		},
	},

	-- Floating clients
	{
		rule_any = {
			instance = {
				"floating_terminal",
				"Devtools", -- Firefox devtools
			},
			class = {
				"Gpick",
				"Lxappearance",
				"Nm-connection-editor",
				"File-roller",
				"fst",
				"Nvidia-settings",
			},
			name = {
				"Event Tester", -- xev
				"MetaMask Notification",
				"Picture in picture",
			},
			role = {
				"AlarmWindow",
				"pop-up",
				"GtkFileChooserDialog",
				"conversation",
			},
			type = {
				"dialog",
			},
		},
		properties = { floating = true },
	},

	-- Fullscreen clients
	{
		rule_any = {
			class = {
				"dota2",
				"dontstarve_steam",
			},
			instance = {
				"synthetik.exe",
			},
		},
		properties = { fullscreen = true },
	},

	-- Centered clients
	{
		rule_any = {
			type = {
				"dialog",
			},
			class = {
				"Steam",
				"discord",
				"music",
				"scratchpad",
			},
			instance = {
				"music",
				"scratchpad",
			},
			role = {
				"GtkFileChooserDialog",
				"conversation",
			},
		},
		properties = { placement = centered_client_placement },
	},

	-- Titlebars ON (explicitly)
	{
		rule_any = {
			type = {
				"dialog",
			},
			role = {
				"conversation",
			},
		},
		callback = function(c)
			decorations.show(c)
		end,
	},

	-- "Needy": Clients that steal focus when they are urgent
	{
		rule_any = {
			class = {
				"TelegramDesktop",
				"firefox",
				"Nightly",
			},
			type = {
				"dialog",
			},
		},
		callback = function(c)
			c:connect_signal("property::urgent", function()
				if c.urgent then
					c:jump_to()
				end
			end)
		end,
	},

	-- Fixed terminal geometry for floating terminals
	{
		rule_any = {
			class = {
				"Alacritty",
				"st-256color",
				"st",
			},
		},
		properties = { width = screen_width * 0.65, height = screen_height * 0.65 },
	},

	-- File chooser dialog
	{
		rule_any = { role = { "GtkFileChooserDialog" } },
		properties = { floating = true, width = screen_width * 0.55, height = screen_height * 0.65 },
	},

	-- Pavucontrol
	{
		rule_any = { class = { "Pavucontrol" } },
		properties = { floating = true, width = screen_width * 0.45, height = screen_height * 0.8 },
	},

	-- Galculator
	{
		rule_any = { class = { "Galculator" } },
		except_any = { type = { "dialog" } },
		properties = { floating = true, width = screen_width * 0.2, height = screen_height * 0.4 },
	},

	-- File managers
	{
		rule_any = {
			class = {
				"Pcmanfm",
				"Nemo",
				"Thunar",
			},
		},
		except_any = {
			type = { "dialog" },
		},
		properties = { floating = true, width = screen_width * 0.45, height = screen_height * 0.55 },
	},

	-- Scratchpad
	{
		rule_any = {
			instance = {
				"scratchpad",
				"markdown_input",
			},
			class = {
				"scratchpad",
				"markdown_input",
			},
		},
		properties = {
			skip_taskbar = false,
			floating = true,
			ontop = false,
			minimized = true,
			sticky = false,
			width = screen_width * 0.7,
			height = screen_height * 0.75,
		},
	},

	-- Music clients (usually a terminal running ncmpcpp)
	{
		rule_any = {
			class = {
				"music",
			},
			instance = {
				"music",
			},
		},
		properties = {
			floating = true,
			width = screen_width * 0.45,
			height = screen_height * 0.50,
		},
	},

	-- Image viewers
	{
		rule_any = {
			class = {
				"feh",
				"Sxiv",
			},
		},
		properties = {
			floating = true,
			width = screen_width * 0.7,
			height = screen_height * 0.75,
		},
		callback = function(c)
			awful.placement.centered(c, { honor_padding = true, honor_workarea = true })
		end,
	},

	-- Steam guard
	{
		rule = { name = "Steam Guard - Computer Authorization Required" },
		properties = { floating = true },
		-- Such a stubborn window, centering it does not work
		-- callback = function(c)
		--     gears.timer.delayed_call(function()
		--         awful.placement.centered(c,{honor_padding = true, honor_workarea=true})
		--     end)
		-- end
	},

	-- MPV
	{
		rule = { class = "mpv" },
		properties = {},
		callback = function(c)
			-- Make it floating, ontop and move it out of the way if the current tag is maximized
			if awful.layout.get(awful.screen.focused()) == awful.layout.suit.max then
				c.floating = true
				c.ontop = true
				c.width = screen_width * 0.30
				c.height = screen_height * 0.35
				awful.placement.bottom_right(c, {
					honor_padding = true,
					honor_workarea = true,
					margins = { bottom = beautiful.useless_gap * 2, right = beautiful.useless_gap * 2 },
				})
			end

			-- Restore `ontop` after fullscreen is disabled
			-- Sorta tries to fix: https://github.com/awesomeWM/awesome/issues/667
			c:connect_signal("property::fullscreen", function()
				if not c.fullscreen then
					c.ontop = true
				end
			end)
		end,
	},

	-- Start application on specific workspace
	-- ===================================================================
	-- Browsing
	{
		rule_any = {
			class = {
				"firefox",
				"Nightly",
				"Vivaldi-stable",
			},
		},
		except_any = {
			role = { "GtkFileChooserDialog" },
			instance = { "Toolkit" },
			type = { "dialog" },
		},
		properties = { screen = 1, tag = awful.screen.focused().tags[1] },
	},

	-- Editing
	{
		rule_any = {
			class = {
				"^editor$",
				"VSCodium",
			},
		},
		properties = { screen = 1, tag = awful.screen.focused().tags[2] },
	},

	-- Games
	{
		rule_any = {
			class = {
				"Wine",
			},
			instance = {},
		},
		properties = { screen = 1, tag = awful.screen.focused().tags[3] },
	},

	-- Chatting
	{
		rule_any = {
			class = {
				"discord",
				"Signal",
				"Slack",
				"zoom",
			},
		},
		properties = { screen = 1, tag = awful.screen.focused().tags[4] },
	},

	-- System monitoring
	{
		rule_any = {
			class = {
				"htop",
				"bottom",
			},
			instance = {
				"htop",
				"bottom",
			},
		},
		properties = { screen = 1, tag = awful.screen.focused().tags[5] },
	},

	-- Image editing
	{
		rule_any = {
			class = {
				"Gimp",
			},
		},
		properties = { screen = 1, tag = awful.screen.focused().tags[6] },
	},

	-- Mail
	{
		rule_any = {
			class = {
				"email",
			},
			instance = {
				"email",
			},
		},
		properties = { screen = 1, tag = awful.screen.focused().tags[6] },
	},

	-- Game clients/launchers
	{
		rule_any = {
			class = {
				"Steam",
				"battle.net.exe",
				"Lutris",
			},
			name = {
				"Steam",
			},
		},
		properties = { screen = 1, tag = awful.screen.focused().tags[6] },
	},

	-- Miscellaneous
	-- All clients that I want out of my way when they are running
	{
		rule_any = {
			class = {
				"torrent",
				"Transmission",
				"Deluge",
				"VirtualBox Manager",
				"KeePassXC",
			},
			instance = {
				"torrent",
				"qemu",
			},
		},
		except_any = {
			type = { "dialog" },
		},
		properties = { screen = 1, tag = awful.screen.focused().tags[6] },
	},
}

-- Signals
-- ===================================================================
if beautiful.border_width > 0 then
	client.connect_signal("focus", function(c)
		c.border_color = beautiful.border_focus
	end)
	client.connect_signal("unfocus", function(c)
		c.border_color = beautiful.border_normal
	end)
end

-- Set mouse resize mode (live or after)
awful.mouse.resize.set_mode("live")

-- Restore geometry for floating clients
-- (for example after swapping from tiling mode to floating mode)
tag.connect_signal("property::layout", function(t)
	for k, c in ipairs(t:clients()) do
		if awful.layout.get(mouse.screen) == awful.layout.suit.floating then
			local cgeo = awful.client.property.get(c, "floating_geometry")
			if cgeo then
				c:geometry(awful.client.property.get(c, "floating_geometry"))
			end
		end
	end
end)

client.connect_signal("manage", function(c)
	if awful.layout.get(mouse.screen) == awful.layout.suit.floating then
		awful.client.property.set(c, "floating_geometry", c:geometry())
	end
end)

client.connect_signal("property::geometry", function(c)
	if awful.layout.get(mouse.screen) == awful.layout.suit.floating then
		awful.client.property.set(c, "floating_geometry", c:geometry())
	end
end)

-- When switching to a tag with urgent clients, raise them.
-- This fixes the issue (visual mismatch) where after switching to
-- a tag which includes an urgent client, the urgent client is
-- unfocused but still covers all other windows (even the currently
-- focused window).
awful.tag.attached_connect_signal(s, "property::selected", function()
	local urgent_clients = function(c)
		return awful.rules.match(c, { urgent = true })
	end
	for c in awful.client.iterate(urgent_clients) do
		if c.first_tag == mouse.screen.selected_tag then
			client.focus = c
		end
	end
end)

-- Enable sloppy focus, so that focus follows mouse.
-- client.connect_signal("mouse::enter", function(c)
-- 	c:activate { context = "mouse_enter", raise = false }
-- end)

-- Raise focused clients automatically
client.connect_signal("focus", function(c)
	c:raise()
end)

-- Focus all urgent clients automatically
-- client.connect_signal("property::urgent", function(c)
-- 	if c.urgent then
-- 		c.minimized = false
-- 		c:jump_to()
-- 	end
-- end)

-- Disable ontop when the client is not floating, and restore ontop if needed
-- when the client is floating again
-- I never want a non floating client to be ontop.
client.connect_signal("property::floating", function(c)
	if c.floating then
		if c.restore_ontop then
			c.ontop = c.restore_ontop
		end
	else
		c.restore_ontop = c.ontop
		c.ontop = false
	end
end)


-- Decorations
-- ===================================================================
local wibox = require("wibox")
-- Apply rounded corners to clients if needed
if beautiful.border_radius and beautiful.border_radius > 0 then
	client.connect_signal("manage", function(c, startup)
		if not c.fullscreen and not c.maximized then
			c.shape = helpers.rrect(beautiful.border_radius)
		end
	end)

	-- Fullscreen and maximized clients should not have rounded corners
	local function no_round_corners(c)
		if c.fullscreen or c.maximized then
			c.shape = gears.shape.rectangle
		else
			c.shape = helpers.rrect(beautiful.border_radius)
		end
	end

	client.connect_signal("property::fullscreen", no_round_corners)
	client.connect_signal("property::maximized", no_round_corners)

	beautiful.snap_shape = helpers.rrect(beautiful.border_radius * 2)
else
	beautiful.snap_shape = gears.shape.rectangle
end

function decorations.show(c)
	if not c.custom_decoration or not c.custom_decoration[beautiful.titlebar_position] then
		awful.titlebar.show(c, beautiful.titlebar_position)
	end
end

-- Dummy titlebar
client.connect_signal("request::titlebars", function(c)
	awful.titlebar(c)
end)

-- Garbage collection
-- ===================================================================
-- collectgarbage("setpause", 110)
-- collectgarbage("setstepmul", 1000)
