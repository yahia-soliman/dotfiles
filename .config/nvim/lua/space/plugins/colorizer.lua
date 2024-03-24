return {
	'norcalli/nvim-colorizer.lua',

	config = function ()
		require("colorizer").setup({ },	{ css = true })
		vim.keymap.set("n", "<leader>c", "<cmd>ColorizerToggle<CR>", {silent = true})
	end,
}
