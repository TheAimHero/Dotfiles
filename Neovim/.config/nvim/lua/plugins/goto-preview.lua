return {
	"rmagatti/goto-preview",
	lazy = true,
	keys = {
		{
			"gP",
			"<cmd>lua require('goto-preview').close_all_win()<CR>",
			mode = "n",
			noremap = true,
			silent = true,
			desc = "Close All Preview",
		},
		{
			"gpd",
			"<cmd>lua require('goto-preview').goto_preview_definition()<CR>",
			mode = "n",
			noremap = true,
			silent = true,
			desc = "Goto Definition",
		},
	},
	config = function()
		local keymap = vim.keymap.set
		require("goto-preview").setup({
			width = 120,
			height = 15,
			border = { "↖", "─", "┐", "│", "┘", "─", "└", "│" },
			default_mappings = false,
			debug = false,
			opacity = nil,
			resizing_mappings = false,
			post_open_hook = function()
				vim.wo.number = false
			end,
			references = {
				telescope = require("telescope.themes").get_dropdown({ hide_preview = false }),
			},
			focus_on_open = true,
			dismiss_on_move = false,
			force_close = true,
			bufhidden = "wipe",
			stack_floating_preview_windows = true,
			preview_window_title = { enable = true, position = "left" },
		})
	end,
}
