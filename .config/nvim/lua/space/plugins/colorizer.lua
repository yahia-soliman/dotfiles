return {
	"nvChad/nvim-colorizer.lua",

	config = function()
		require("colorizer").setup({
			filetypes = { "*" },
			user_default_options = {
				css = true,
				tailwind = true,
			},
		})
		vim.keymap.set("n", "<leader>c", "<cmd>ColorizerToggle<CR>", { silent = true })
	end,
}
