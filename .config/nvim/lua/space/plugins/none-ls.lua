return {
	"nvimtools/none-ls.nvim",
	enabled = false,
	event = "VeryLazy",
	opts = function()
		local null_ls = require("null-ls")
		return {
			sources = {
				null_ls.builtins.formatting.prettierd,
			},
			on_attach = function(_, bufnr)
				vim.keymap.set("n", "<leader>=", function()
					vim.lsp.buf.format({ bufnr = bufnr })
				end)
			end,
		}
	end,
}
