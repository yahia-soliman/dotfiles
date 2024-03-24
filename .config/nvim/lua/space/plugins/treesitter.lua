return {
	'nvim-treesitter/nvim-treesitter',
	build = ':TSUpdate',
	config = function ()
		require'nvim-treesitter.configs'.setup {
			-- A list of parser names, or "all" (the five listed parsers should always be installed)
			ensure_installed = { "c", "python", "go", "html", "css", "javascript", "lua", "vim",  "query" },

			-- Install parsers synchronously (only applied to `ensure_installed`)
			sync_install = false,

			-- Automatically install missing parsers when entering buffer
			auto_install = false,

			highlight = {
				enable = true,

				additional_vim_regex_highlighting = false,
			},
		}
	end
}
