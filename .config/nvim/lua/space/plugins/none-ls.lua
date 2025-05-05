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
				null_ls.builtins.formatting.biome,
				null_ls.builtins.formatting.black,
				null_ls.builtins.formatting.isort,
				null_ls.builtins.formatting.shfmt,
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.diagnostics.markuplint,
				null_ls.builtins.diagnostics.phpstan,
				null_ls.builtins.formatting.pint,
				null_ls.builtins.formatting.tidy, -- html, xml (needs tidy binary)
				null_ls.builtins.formatting.mix, -- needs mix binary (elixir)
				null_ls.builtins.diagnostics.credo, -- needs mix binary (elixir)
				-- null_ls.builtins.formatting.dart_format, -- needs dart binary
				null_ls.builtins.formatting.sqlfluff.with({
					extra_args = { "--dialect", "postgres" },
				}),
				-- null_ls.builtins.formatting.prisma_format, -- needs prisma binary
			},
		})
		require("mason-tool-installer").setup({
			ensure_installed = {
				"biome",
				"black",
				"isort",
				"shfmt",
				"stylua",
				"markuplint",
				"sqlfluff",
				"phpstan",
				"pint",
			},
		})
	end,
}
