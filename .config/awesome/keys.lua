-- ░█░█░█▀▀░█░█░█▀▄░▀█▀░█▀█░█▀▄░█▀▀
-- ░█▀▄░█▀▀░░█░░█▀▄░░█░░█░█░█░█░▀▀█
-- ░▀░▀░▀▀▀░░▀░░▀▀░░▀▀▀░▀░▀░▀▀░░▀▀▀

local gears = require("gears")
local beautiful = require("beautiful")
local awful = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup")
local helpers = require("helpers")
local awesome = awesome
local client = client
local root = root
local keys = {}

local mod = "Mod4"
local alt = "Mod1"
local ctrl = "Control"
local shift = "Shift"

-- Global bindings
-- =============================================
keys.globalkeys = gears.table.join(
	awful.key({
		modifiers = { mod },
		keygroup = "numrow",
		description = "only view tag",
		group = "tag",
		on_press = function(index)
			local screen = awful.screen.focused()
			local tag = screen.tags[index]
			if tag then
				tag:view_only()
			end
		end,
	}),
	awful.key({
		modifiers = { mod, shift },
		keygroup = "numrow",
		description = "move focused client to tag",
		group = "tag",
		on_press = function(index)
			if client.focus then
				local tag = client.focus.screen.tags[index]
				if tag then
					client.focus:move_to_tag(tag)
				end
			end
		end,
	}),
	awful.key({ mod }, "space", function()
		awful.layout.inc(1)
	end, { description = "next layout", group = "tag" }),
	awful.key({ mod, shift }, "space", function()
		awful.layout.inc(-1)
	end, { description = "previous layout", group = "tag" }),

	-- Tag switcher
	awful.key({ mod }, "Tab", function()
		awful.tag.viewnext()
	end, { description = "next tag", group = "client" }),
	awful.key({ mod, shift }, "Tab", function()
		awful.tag.viewprev()
	end, { description = "prev tag", group = "client" }),

	awful.key({ mod }, "b", function ()
              local myscreen = awful.screen.focused()
              myscreen.mywibox.visible = not myscreen.mywibox.visible
          end, {description = "toggle statusbar", group = "awesome"}),

	-- Focus client by index (cycle through clients)
	awful.key({ mod }, "j", function()
		awful.client.focus.byidx(1)
	end, { description = "focus next by index", group = "client" }),
	awful.key({ mod }, "k", function()
		awful.client.focus.byidx(-1)
	end, { description = "focus prev by index", group = "client" }),

	-- Focus client by direction (arrow keys)
	awful.key({ mod }, "Down", function()
		awful.client.focus.bydirection("down")
	end, { description = "focus down", group = "client" }),
	awful.key({ mod }, "Up", function()
		awful.client.focus.bydirection("up")
	end, { description = "focus up", group = "client" }),
	awful.key({ mod }, "Left", function()
		awful.client.focus.bydirection("left")
	end, { description = "focus left", group = "client" }),
	awful.key({ mod }, "Right", function()
		awful.client.focus.bydirection("right")
	end, { description = "focus right", group = "client" }),

	-- Urgent or Undo:
	-- Jump to urgent client or (if there is no such client) go back
	-- to the last tag
	awful.key({ mod }, "u", function()
		local uc = awful.client.urgent.get()
		-- If there is no urgent client, go back to last tag
		if uc == nil then
			awful.tag.history.restore()
		else
			awful.client.urgent.jumpto()
		end
	end, { description = "jump to urgent client", group = "client" }),

--	awful.key({ mod }, "x", function()
--		awful.tag.history.restore()
--	end, { description = "go back", group = "tag" }),

	-- Spawn terminal
	awful.key({ mod }, "Return", function()
		awful.spawn(user.terminal)
	end, { description = "open a terminal", group = "launcher" }),

	-- Spawn floating terminal
	awful.key({ mod, shift }, "Return", function()
		awful.spawn(user.floating_terminal, { floating = true })
	end, { description = "spawn floating terminal", group = "launcher" }),

	-- Scratchpad terminal
	awful.key({ mod }, "s", function()
		helpers.scratchpad({ instance = "scratchpad" }, user.scratchpad_terminal, nil)
	end, { description = "scratchpad", group = "launcher" }),

	-- Reload Awesome
	awful.key({ mod, shift }, "r", function()
		awesome.restart()
	end, { description = "reload awesome", group = "awesome" }),

	-- Quit Awesome
	awful.key({ mod, shift }, "q", function()
		awesome.quit()
	end, { description = "quit awesome", group = "awesome" }),

	-- Resize focused client or layout factor
	awful.key({ mod, ctrl }, "Down", function(c)
		helpers.resize_dwim(client.focus, "down")
	end),
	awful.key({ mod, ctrl }, "Up", function(c)
		helpers.resize_dwim(client.focus, "up")
	end),
	awful.key({ mod, ctrl }, "Left", function(c)
		helpers.resize_dwim(client.focus, "left")
	end),
	awful.key({ mod, ctrl }, "Right", function(c)
		helpers.resize_dwim(client.focus, "right")
	end),
	awful.key({ mod, ctrl }, "j", function(c)
		helpers.resize_dwim(client.focus, "down")
	end),
	awful.key({ mod, ctrl }, "k", function(c)
		helpers.resize_dwim(client.focus, "up")
	end),
	awful.key({ mod, ctrl }, "h", function(c)
		helpers.resize_dwim(client.focus, "left")
	end),
	awful.key({ mod, ctrl }, "l", function(c)
		helpers.resize_dwim(client.focus, "right")
	end),

	-- Focus restored client
	awful.key({ mod, shift }, "n", function()
		local c = awful.client.restore()
		if c then
			client.focus = c
		end
	end, { description = "restore minimized", group = "client" }),

	-- Screen Shots/Vids
	awful.key({ shift }, "Print", apps.screenshot_full, { description = "screenshot gui", group = "awesome" }),
	awful.key({}, "Print", apps.screenshot_clipboard, { description = "screenshot clipboard", group = "awesome" }),

	-- Prompt
	awful.key({ mod }, "d", function()
		awful.screen.focused().mypromptbox:run()
	end, { description = "run prompt", group = "launcher" }),
	--- App launcher
	awful.key({ mod }, "a", function()
		awful.spawn(user.app_launcher)
	end, { description = "app launcher", group = "app" }),
	--- Emoji picker
	awful.key({ mod }, "e", apps.emoji_picker, { description = "emoji picker", group = "app" }),
	--- Clipboard
	awful.key({ mod }, "p", apps.clipboard, { description = "clipboard", group = "app" }),

	-- Hotkeys list
	awful.key({ mod }, "F1", function()
		hotkeys_popup.show_help()
	end, { description = "show help", group = "awesome" }),

	-- Volume control with volume keys
	awful.key({}, "XF86AudioMute", function()
		helpers.volume_control(0)
	end, { description = "(un)mute volume", group = "volume" }),
	awful.key({}, "XF86AudioLowerVolume", function()
		helpers.volume_control(-5)
		awesome.emit_signal("summon::osd")
	end, { description = "lower volume", group = "volume" }),
	awful.key({}, "XF86AudioRaiseVolume", function()
		helpers.volume_control(5)
		awesome.emit_signal("summon::osd")
	end, { description = "raise volume", group = "volume" }),

	-- Brightness control with brightness keys
	awful.key({}, "XF86MonBrightnessUp", function()
		awful.spawn("light -A 10")
		awesome.emit_signal("summon::osd")
	end, { description = "increase brightness", group = "brightness" }),
	awful.key({}, "XF86MonBrightnessDown", function()
		awful.spawn("light -U 10")
		awesome.emit_signal("summon::osd")
	end, { description = "decrease brightness", group = "brightness" }),


	-- Apps
	-- Spawn browser
	awful.key({ mod }, "F2", apps.browser, { description = "web browser", group = "launcher" }),
	-- Spawn gui file manager
	awful.key({ mod }, "F3", apps.file_manager, { description = "file manager", group = "launcher" }),
	-- Primary editor
	awful.key({ mod }, "F4", apps.editor, { description = "editor", group = "launcher" }),
	-- Volume control
	awful.key({ mod }, "F5", apps.volume, { description = "volume control", group = "launcher" }),
	-- Process monitor
	awful.key({ mod }, "F6", apps.process_monitor, { description = "process monitor", group = "launcher" })
)

-- Client related bindings
-- =============================================
keys.clientkeys = gears.table.join(
	-- Swap by direction
	awful.key({ mod, shift }, "j", function()
		awful.client.swap.bydirection("down")
	end),
	awful.key({ mod, shift }, "k", function()
		awful.client.swap.bydirection("up")
	end),
	awful.key({ mod, shift }, "h", function()
		awful.client.swap.bydirection("left")
	end),
	awful.key({ mod, shift }, "l", function()
		awful.client.swap.bydirection("right")
	end),

	-- Toggle fullscreen
	awful.key({ mod }, "f", function(c)
		c.fullscreen = not c.fullscreen
		c:raise()
	end, { description = "toggle fullscreen", group = "client" }),

	-- Close client
	awful.key({ mod }, "q", function(c)
		c:kill()
	end, { description = "close", group = "client" }),
	awful.key({ alt }, "F4", function(c)
		c:kill()
	end, { description = "close", group = "client" }),

	--- Center client
	awful.key({ mod }, "c", function()
		awful.placement.centered(c, { honor_workarea = true, honor_padding = true })
	end),

	-- Switch clients
	awful.key({ alt }, "Tab", function()
		awesome.emit_signal("window_switcher::turn_on")
		-- awful.client.focus.byidx(1)
	end, { description = "focus next by index", group = "client" }),

	-- Toggle floating
	awful.key({ mod, ctrl }, "space", function(c)
		local layout_is_floating = (awful.layout.get(mouse.screen) == awful.layout.suit.floating)
		if not layout_is_floating then
			awful.client.floating.toggle()
		end
	end, { description = "toggle floating", group = "client" }),

	-- Set master
	awful.key({ mod, ctrl }, "Return", function(c)
		c:swap(awful.client.getmaster())
	end, { description = "move to master", group = "client" }),

	-- P for pin: keep on top OR sticky
	-- On top
	awful.key({ mod, shift }, "p", function(c)
		c.ontop = not c.ontop
	end, { description = "toggle keep on top", group = "client" }),
	-- Sticky
	awful.key({ mod, ctrl }, "p", function(c)
		c.sticky = not c.sticky
	end, { description = "toggle sticky", group = "client" }),

	-- Minimize
	awful.key({ mod }, "n", function(c)
		c.minimized = true
	end, { description = "minimize", group = "client" }),

	-- Maximize
	awful.key({ mod }, "m", function(c)
		c.maximized = not c.maximized
	end, { description = "(un)maximize", group = "client" }),
	awful.key({ mod, ctrl }, "m", function(c)
		c.maximized_vertical = not c.maximized_vertical
		c:raise()
	end, { description = "(un)maximize vertically", group = "client" }),
	awful.key({ mod, shift }, "m", function(c)
		c.maximized_horizontal = not c.maximized_horizontal
		c:raise()
	end, { description = "(un)maximize horizontally", group = "client" })
)

-- Mouse buttons on the client (whole window, not just titlebar)
-- =============================================
keys.clientbuttons = gears.table.join(
	awful.button({}, 1, function(c)
		client.focus = c
	end),
	awful.button({ mod }, 1, awful.mouse.client.move),
	-- awful.button({ mod }, 2, function(c) c:kill() end),
	awful.button({ mod }, 2, function(c)
		client.focus = c
		awful.mouse.client.resize(c)
	end)

	-- Super + scroll = Change client opacity
	-- awful.button({ mod }, 4, function(c)
	-- 	c.opacity = c.opacity + 0.1
	-- end),
	-- awful.button({ mod }, 5, function(c)
	-- 	c.opacity = c.opacity - 0.1
	-- end)
)

-- Mouse buttons on the tasklist
-- Use 'Any' modifier so that the same buttons can be used in the floating
-- tasklist displayed by the window switcher while the mod is pressed
-- =============================================
keys.tasklist_buttons = gears.table.join(
	awful.button({ "Any" }, 1, function(c)
		if c == client.focus then
			c.minimized = true
		else
			-- Without this, the following
			-- :isvisible() makes no sense
			c.minimized = false
			if not c:isvisible() and c.first_tag then
				c.first_tag:view_only()
			end
			-- This will also un-minimize
			-- the client, if needed
			client.focus = c
		end
	end),
	awful.button({ "Any" }, 3, function(c)
		c.minimized = true
	end),
	awful.button({ "Any" }, 4, function()
		awful.client.focus.byidx(-1)
	end),
	awful.button({ "Any" }, 5, function()
		awful.client.focus.byidx(1)
	end),

	-- Side button up - toggle floating
	awful.button({ "Any" }, 9, function(c)
		c.floating = not c.floating
	end),
	-- Side button down - toggle ontop
	awful.button({ "Any" }, 8, function(c)
		c.ontop = not c.ontop
	end)
)

-- Mouse buttons on a tag of the taglist widget
-- =============================================
keys.taglist_buttons = gears.table.join(
	awful.button({}, 1, function(t)
		t:view_only()
	end),
	awful.button({ mod }, 1, function(t)
		if client.focus then
			client.focus:move_to_tag(t)
		end
	end),
	-- awful.button({ }, 3, awful.tag.viewtoggle),
	awful.button({}, 3, function(t)
		if client.focus then
			client.focus:move_to_tag(t)
		end
	end),
	awful.button({ mod }, 3, function(t)
		if client.focus then
			client.focus:toggle_tag(t)
		end
	end),
	awful.button({}, 4, function(t)
		awful.tag.viewprev(t.screen)
	end),
	awful.button({}, 5, function(t)
		awful.tag.viewnext(t.screen)
	end)
)

root.keys(keys.globalkeys)
root.buttons(keys.desktopbuttons)

return keys
-- EOF ------------------------------------------------------------------------
