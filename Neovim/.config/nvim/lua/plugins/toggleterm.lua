return {
	"akinsho/toggleterm.nvim",
	cmd = "ToggleTerm",
	config = function()
		require("toggleterm").setup({
			autochdir = true,
			float_opts = { border = "single" },
			shade_terminals = false,
		})
	end,
}
