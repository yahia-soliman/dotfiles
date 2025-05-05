return {
	"catppuccin/nvim",
	priority = 999,
	config = function()
		require("catppuccin").setup({
			-- transparent_background = true,
			integrations = {
				cmp = true,
				gitsigns = true,
				treesitter = true,
				fidget = true,
				telescope = {
					enabled = true,
					style = "nvchad",
				},
				mini = {
					enabled = true,
					indentscope_color = "",
				},
				rainbow_delimiters = true,
			},
		})
	end,
	init = function ()
		vim.cmd.colorscheme("catppuccin-mocha")
	end
}
