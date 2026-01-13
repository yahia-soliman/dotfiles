return {
	"stevearc/oil.nvim",
	---@module 'oil'
	---@type oil.SetupOpts
	opts = {},
	config = function()
		oil = require("oil")
		oil.setup()
		vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
		vim.keymap.set("n", "<leader>-", oil.toggle_float, { desc = "Open Parenet Directory (Floating)" })
	end,
	dependencies = { { "nvim-mini/mini.icons", opts = {} } },
	lazy = false,
}
