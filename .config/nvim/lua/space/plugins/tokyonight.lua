return {
	"folke/tokyonight.nvim",
	enabled = false,
	priority = 1000,
	---@class tokyonight.Config
	opts = {
		style = "night",
		light_style = "day",
		plugins = { auto = true },
		-- transparent = true,
		on_colors = function(c)
			local util = require("tokyonight.util")
			local bg_dark = c.bg_dark
			c.bg_dark = c.bg_highlight
			c.bg_float = c.bg_highlight
			c.bg_popup = util.lighten(c.bg, 0.95)
			c.bg_visual = util.lighten(c.bg, 0.8)
			c.bg_highlight = bg_dark
			c.git = {
				add = c.teal,
				change = c.magenta,
				delete = c.red,
			}
		end,
		on_highlights = function(hl, c)
			local util = require("tokyonight.util")
			local bg = c.bg_popup
			local prompt = c.bg_visual
			local invisible = { bg = bg, fg = bg }

			hl.LineNr = { fg = util.lighten(c.fg_gutter, 0.7) }

			hl.TelescopeNormal = { bg = bg, fg = c.fg_dark }
			hl.TelescopePromptNormal = { bg = prompt }
			hl.TelescopePromptBorder = { bg = prompt, fg = prompt }
			hl.TelescopePromptTitle = { bg = prompt, fg = c.fg_dark }
			hl.TelescopeBorder = invisible
			hl.TelescopePreviewTitle = invisible
			hl.TelescopeResultsTitle = invisible

			hl.Floaterm = { bg = bg }
			hl.FloatermBorder = invisible
		end,
	},
	init = function()
		vim.cmd.colorscheme("tokyonight")

		-- You can configure highlights by doing something like:
		vim.cmd.hi("Comment gui=none")
	end,
}
