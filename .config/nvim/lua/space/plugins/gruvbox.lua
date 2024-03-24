return {
	'ellisonleao/gruvbox.nvim',

	config = function ()
		require('gruvbox').setup({
			transparent_mode = true,
			italic = {
				strings = false,
				emphasis = true,
				comments = false,
				operators = false,
				folds = true,
			},
			--[[
			palette_overrides = {
				light1 = "#F2C185",
				grey = "#333934",
				faded_red = "#BF0404",
				bright_orange = "#F28322",
				bright_orange = "#F28322",
			},

			overrides = {
				Conditional = { link = "GruvboxRedBold" },
				Repeat = { link = "GruvboxRedBold" },
			},
			]]--
		})
		vim.cmd.colorscheme("gruvbox")
	end
}
