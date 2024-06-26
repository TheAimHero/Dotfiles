return {
	"akinsho/bufferline.nvim",
	event = "User FileOpened",
	dependencies = "DaikyXendo/nvim-web-devicons",
	keys = {
		{ "<leader>bs", "<cmd>BufferLinePick<cr>", desc = "Jump" },
		{ "<leader>be", "<cmd>BufferLinePickClose<cr>", desc = "Pick which buffer to close" },
		{ "<leader>bg", "<cmd>BufferLineCloseLeft<cr>", desc = "Close all to Left" },
		{ "<leader>bh", "<cmd>BufferLineCloseRight<cr>", desc = "Close all to Right" },
	},
	config = function()
		local mocha = require("catppuccin.palettes").get_palette("mocha")
		require("bufferline").setup({
			options = {
				numbers = function(number_opts)
					local harpoon = require("harpoon.mark")
					local buf_name = vim.api.nvim_buf_get_name(number_opts.id)
					local harpoon_mark = harpoon.get_index_of(buf_name)
					return harpoon_mark
				end,
				separator_style = "slope",
				offsets = {
					{ filetype = "neo-tree", text_align = "center", separator = false },
				},
			},
		})
	end,
}
