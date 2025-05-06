return {
	"nvimtools/none-ls.nvim",
	event = "VeryLazy",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		vim.keymap.set("n", "<leader>=", vim.lsp.buf.format)
		local null_ls = require("null-ls")
		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.black,
				null_ls.builtins.formatting.isort,
				null_ls.builtins.formatting.shfmt,
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.prettierd,
				null_ls.builtins.diagnostics.markuplint,
				null_ls.builtins.formatting.sqlfluff.with({
					extra_args = { "--dialect", "postgres" },
				}),
				-- null_ls.builtins.formatting.dart_format, -- needs dart binary
				-- null_ls.builtins.formatting.prisma_format, -- needs prisma binary
			},
		})

		require("mason-tool-installer").setup({
			ensure_installed = {
				"prettierd",
				"black",
				"isort",
				"shfmt",
				"stylua",
				"markuplint",
				"sqlfluff",
			},
		})
	end,
}
