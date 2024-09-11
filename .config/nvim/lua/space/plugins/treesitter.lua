return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	opts = {
		-- Automatically install missing parsers when entering buffer
		auto_install = true,
		indent = { enable = true },

		highlight = {
			enable = true,
			additional_vim_regex_highlighting = false,
		},
	},
}
