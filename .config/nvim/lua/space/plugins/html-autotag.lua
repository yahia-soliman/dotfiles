return {
	"windwp/nvim-ts-autotag",
	ft = {
		"xml",
		"html",
		"htmldjango",
		"javascript",
		"typescript",
		"javascriptreact",
		"typescriptreact",
	},
	config = function()
		require("nvim-ts-autotag").setup()
	end,
}
