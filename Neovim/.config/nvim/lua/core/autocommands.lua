local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

local disable_table = {
	"toggleterm",
	"DiffviewFileHistory",
	"diff",
	"neo-tree",
	"DiffviewFiles",
	"lazy",
	"mason",
	"Trouble",
	"Outline",
	"fugitive",
	"git",
	"alpha",
	"TelescopPrompt",
	"help",
	"man",
	"terminal",
	"qf",
	"nowrite",
	"norg",
}

-- Make alpha popup when no buffers remain
-- @note: Find a way to make this work without BDeletePost
augroup("alpha_on_empty", { clear = true })
autocmd("User", {
	pattern = "BDeletePost*",
	group = "alpha_on_empty",
	callback = function(event)
		local fallback_name = vim.api.nvim_buf_get_name(event.buf)
		local fallback_ft = vim.bo.filetype

		local fallback_on_empty = fallback_name == "" and fallback_ft == ""
		if fallback_on_empty then
			vim.cmd("Alpha")
			vim.cmd(event.buf .. "bwipeout")
		end
	end,
})

--Disable mini on some filetype
augroup("Disable_Plugins", { clear = true })
autocmd({ "FileType" }, {
	pattern = disable_table,
	group = "Disable_Plugins",
	callback = function()
		vim.b.miniindentscope_disable = true
		vim.b.minicursorword_disable = true
		vim.b.minijump_disable = true
	end,
})

autocmd("FileType", {
	pattern = { "Outline" },
	callback = function()
		require("ufo").detach()
		vim.opt_local.foldenable = false
		vim.wo.foldcolumn = "0"
	end,
})

-- @note: This is when we want to do something before closing a buffer
local save_fold = augroup("Persistent Folds", { clear = true })
autocmd("BufWinLeave", {
	pattern = "*.*",
	callback = function() end,
	group = save_fold,
})

-- @note: This is when we want to do something after opening a buffer
autocmd("BufWinEnter", {
	pattern = "*.*",
	callback = function() end,
	group = save_fold,
})

-- Persistent Cursor
autocmd("BufReadPost", {
	callback = function()
		local mark = vim.api.nvim_buf_get_mark(0, '"')
		local lcount = vim.api.nvim_buf_line_count(0)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

augroup("_file_opened", { clear = true })
autocmd({ "BufRead", "BufWinEnter", "BufNewFile" }, {
	group = "_file_opened",
	once = true,
	callback = function(args)
		local buftype = vim.api.nvim_get_option_value("buftype", { buf = args.buf })
		if not (vim.fn.expand("%") == "" or buftype == "nofile") then
			vim.cmd("do User FileOpened")
		end
	end,
})

local function is_directory(path)
	local stat = vim.loop.fs_stat(path)
	return stat and stat.type == "directory" or false
end

augroup("_dir_opened", { clear = true })
autocmd("BufEnter", {
	group = "_dir_opened",
	once = true,
	callback = function(args)
		local bufname = vim.api.nvim_buf_get_name(args.buf)
		if is_directory(bufname) then
			vim.api.nvim_del_augroup_by_name("_dir_opened")
			vim.cmd("do User DirOpened")
			vim.api.nvim_exec_autocmds("BufEnter", {})
		end
	end,
})

autocmd("LspAttach", {
	group = augroup("UserLspConfig", {}),
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if client and client.server_capabilities.inlayHintProvider then
			vim.lsp.inlay_hint.enable(true)
		end
	end,
})
