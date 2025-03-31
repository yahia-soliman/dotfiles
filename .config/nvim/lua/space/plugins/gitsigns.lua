return {
	"lewis6991/gitsigns.nvim",
	lazy = false,
	keys = {
		{ "]h", ":silent Gitsigns next_hunk<CR>" },
		{ "[h", ":silent Gitsigns prev_hunk<CR>" },
		{ "gh", ":Gitsigns preview_hunk<CR>" },
		{ "gb", ":Gitsigns blame_line<CR>" },
	},
	opts = {
		preview_config = {
			border = { "", "", "", " " },
		},
		signs = {
			add = { text = "┃" },
			change = { text = "┃" },
			changedelete = { text = "┃" },
			delete = { text = "_" },
			topdelete = { text = "‾" },
			untracked = { text = "┊" },
		},
	},
}
