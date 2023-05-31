-- TODO: load this only when wanted and then set the key mappings?
-- Configuration lives in vimspector/configurations/<OS>/<filetype>/*.json, see
-- https://puremourning.github.io/vimspector/configuration.html#debug-configurations

vim.g.vimspector_base_dir = os.getenv("HOME") .. "/.config/nvim/lua/user/vimspector/"

-- vimspector mappings (see https://github.com/puremourning/vimspector#human-mode)
vim.g.vimspector_enable_mappings = "HUMAN"

local M = {}

local function debuggers()
	vim.g.vimspector_install_gadgets = {
		"debugpy", -- Python
		"vscode-cpptools", --Cpp
	}
end

function M.toggle_human_mode()
	if vim.g.vimspector_enable_mappings == nil then
		vim.g.vimspector_enable_mappings = "HUMAN"
		print("Enabled HUMAN mappings")
	else
		vim.g.vimspector_enable_mappings = nil
		print("Disabled HUMAN mappings")
	end
end

function M.setup()
	vim.cmd([[packadd! vimspector]]) -- Load vimspector
	debuggers() -- Configure debuggers
end

return M
