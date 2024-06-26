return {
	-- a number <1 is a percentage., >1 is a fixed size
	defaults = {
		version = false,
	},
	position = "center",
	install = { colorscheme = { "catppuccin", "lunar", "tokyonight-moon", "carbonfox", "habamax" } },
	checker = { enabled = false },
	ui = {
		size = { width = 0.6, height = 0.8 },
		border = "single",
		icons = {
			cmd = " ",
			config = "",
			event = "",
			ft = " ",
			init = " ",
			import = " ",
			keys = " ",
			lazy = "鈴 ",
			loaded = "●",
			not_loaded = "○",
			plugin = " ",
			runtime = " ",
			source = " ",
			start = "",
			task = "✔ ",
			list = {
				"●",
				"➜",
				"★",
				"‒",
			},
		},
	},
}
