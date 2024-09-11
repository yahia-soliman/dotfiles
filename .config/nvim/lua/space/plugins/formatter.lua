return { -- Autoformat
	"stevearc/conform.nvim",

	-- for type hints
	---@module "conform"
	---@type conform.setupOpts
	opts = {
		notify_on_error = true,
		formatters = {
			prettierd = {
				stdin = true,
			},
		},
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "black", "isort" },
			javascript = { "prettierd" },
			typescript = { "prettierd" },
			html = { "prettierd" },
			djangohtml = { "prettierd" },
		},
	},
	init = function()
		vim.keymap.set("n", "<leader>=", require("conform").format)
	end,
}
