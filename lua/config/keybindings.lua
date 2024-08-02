-----------------------------|
--- Mapping function keys ---|
-----------------------------|
-- https://unix.stackexchange.com/questions/53581/sending-function-keys-f1-f12-over-ssh/53589#53589
-- https://stackoverflow.com/questions/19062315/how-do-i-find-out-what-escape-sequence-my-terminal-needs-to-send
-- https://www.reddit.com/r/neovim/comments/1111ixq/there_are_60_f_keys/j8e2x5n/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
--
-- Nvim maps modifiers + function keys to other function keys. Pressing Shift+F5, for example, yields "<F17>".
--
-- You could also adapt the characters that your terminal is emitting.
-- For alacritty, see https://github.com/alacritty/alacritty/issues/690
-- Note that those keybindings don't work for `xterm` which uses different
-- modifiers (see https://www.xfree86.org/current/ctlseqs.html).
-----------------------------|

local customKeymap = require("utils.customKeymap")

--Remap space as leader key
customKeymap("", "<Space>", "<Nop>", "Leader key")

-- Categories
customKeymap("n", "<leader>d", "<Nop>", "Debug")
customKeymap("n", "<leader>f", "<Nop>", "Telescope")
customKeymap("n", "<leader>g", "<Nop>", "Git")
customKeymap("n", "<leader>l", "<Nop>", "LSP")

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
-- customKeymap("n", "<M-h>", "<C-w>h", "Navigate to the left split")key
-- customKeymap("n", "<M-j>", "<C-w>j", "Navigate to the bottom split")
-- customKeymap("n", "<M-k>", "<C-w>k", "Navigate to the top split")
-- customKeymap("n", "<M-l>", "<C-w>l", "Navigate to the right split")

-- Scrolling
customKeymap("n", "<C-d>", "<C-d>zz", "Scroll windows downwards and centre window")
customKeymap("n", "<C-u>", "<C-u>zz", "Scroll windows upwards and centre window")

-- Search
customKeymap("n", "n", "nzzzv", "Repeat search, centre and open fold")
customKeymap("n", "N", "Nzzzv", "Repeat search backwards, centre and open fold")

-- Custom navigator bindings (as set in tmux)
customKeymap("n", "<M-h>", '<cmd>lua require("tmux").move_left()<cr>', "Move cursor to left pane")
customKeymap("n", "<M-j>", '<cmd>lua require("tmux").move_bottom()<cr>', "Move cursor to bottom pane")
customKeymap("n", "<M-k>", '<cmd>lua require("tmux").move_top()<cr>', "Move cursor to top pane")
customKeymap("n", "<M-l>", '<cmd>lua require("tmux").move_right()<cr>', "Move cursor to right pane")

-- Resize with arrows
customKeymap("n", "<M-Up>", '<cmd>lua require("tmux").resize_top()<cr>', "Resize top")
customKeymap("n", "<M-Down>", '<cmd>lua require("tmux").resize_bottom()<cr>', "Resize bottom")
customKeymap("n", "<M-Left>", '<cmd>lua require("tmux").resize_left()<cr>', "Resize left")
customKeymap("n", "<M-Right>", '<cmd>lua require("tmux").resize_right()<cr>', "Resize right")

-- Clear highlights
customKeymap("n", "<leader>h", "<cmd>nohlsearch<CR>", "Clear highlights")

-- Close buffer
customKeymap("n", "<A-q>", ":bd<CR>", "Close buffer")

-- Better paste
customKeymap("v", "p", "P", "Better paste")

-- Insert --
-- Press jk fast to enter
customKeymap("i", "jk", "<ESC>", "Better escape")

-- Visual --
-- Stay in indent mode
customKeymap("v", "<", "<gv", "Indent to the left")
customKeymap("v", ">", ">gv", "Indent to the right")

-- Moving selected lines
customKeymap("v", "J", ":m '>+1<CR>gv=gv", "Move selection one down")
customKeymap("v", "K", ":m '<-2<CR>gv=gv", "Move selection one up")

-- Plugins --

-- NvimTree
customKeymap("n", "<leader>e", ":NvimTreeToggle<CR>", "Toggle explorer")
customKeymap("n", "<C-n>", ":NvimTreeToggle<CR>", "Toggle explorer")

-- Telescope
customKeymap("n", "<leader>f", "", "Telescope (find ...)")
customKeymap(
  "n",
  "<leader>ff",
  "<cmd>lua require('telescope.builtin').find_files({ hidden = true, no_ignore = true, no_ignore_parent = true })<CR>",
  "Find all files"
)
customKeymap("n", "<leader>ft", ":Telescope live_grep<CR>", "Find words")
customKeymap("n", "<leader>fp", ":Telescope projects<CR>", "Find projects")
customKeymap("n", "<leader>fb", ":Telescope buffers<CR>", "Find buffers")
customKeymap("n", "<leader>fh", ":Telescope help_tags<CR>", "List help tags")
customKeymap(
  "n",
  "<C-p>",
  "<CMD>lua require('plugins.telescope').project_files()<CR>",
  "Find project files (respects gitignore)"
)
customKeymap(
  "n",
  "<leader>fs",
  "<CMD>lua require('telescope.builtin').grep_string { search = vim.fn.input 'Grep > ' }<CR>",
  "Find word"
)

-- Git
customKeymap("n", "<leader>gg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", "Lazygit")
customKeymap("n", "<leader>gl", "<cmd>lua require('gitsigns').blame_line()<cr>", "View Git blame")
customKeymap("n", "<leader>gL", "<cmd>lua require('gitsigns').blame_line { full = true }<cr>", "View full Git blame")
customKeymap("n", "<leader>gp", "<cmd>lua require('gitsigns').preview_hunk()<cr>", "Preview Git hunk")
customKeymap("n", "<leader>gr", "<cmd>lua require('gitsigns').reset_hunk()<cr>", "Reset Git hunk")
customKeymap(
  "v",
  "<leader>gr",
  "<cmd>lua require('gitsigns').reset_hunk {vim.fn.line('.'), vim.fn.line('v')}<cr>",
  "Reset Git selection"
)
customKeymap("n", "<leader>gR", "<cmd>lua require('gitsigns').reset_buffer()<cr>", "Reset Git buffer")
customKeymap("n", "<leader>gs", "<cmd>lua require('gitsigns').stage_hunk()<cr>", "Stage Git hunk")
customKeymap(
  "v",
  "<leader>gs",
  "<cmd>lua require('gitsigns').stage_hunk {vim.fn.line('.'), vim.fn.line('v')}<cr>",
  "Reset Git selection"
)
customKeymap("n", "<leader>gS", "<cmd>lua require('gitsigns').stage_buffer()<cr>", "Stage Git buffer")
customKeymap("n", "<leader>gu", "<cmd>lua require('gitsigns').undo_stage_hunk()<cr>", "Unstage Git hunk")
customKeymap("n", "<leader>gd", "<cmd>lua require('gitsigns').diffthis()<cr>", "View Git diff")
customKeymap("n", "<leader>gj", "<cmd>lua require('gitsigns').next_hunk()<cr>", "Next Hunk")
customKeymap("n", "<leader>gk", "<cmd>lua require('gitsigns').prev_hunk()<cr>", "Prev Hunk")

-- Comment
customKeymap("n", "<leader>/", "<cmd>lua require('Comment.api').toggle.linewise.current()<CR>", "Toggle comment line")
customKeymap(
  "x",
  "<leader>/",
  "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
  "Toggle comment line"
)
customKeymap("n", "<C-S-_>", "<cmd>lua require('Comment.api').toggle.linewise.current()<CR>", "Toggle comment line")
customKeymap(
  "x",
  "<C-S-_>",
  "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
  "Toggle comment line"
)
customKeymap("n", "<C-_>", "<cmd>lua require('Comment.api').toggle.linewise.current()<CR>", "Toggle comment line")
customKeymap(
  "x",
  "<C-_>",
  "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
  "Toggle comment line"
)

-- DAP
customKeymap("n", "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Toggle breakpoint")
customKeymap("n", "<leader>de", "<cmd>lua require('dapui').eval()<cr>", "Evaluate expression")
customKeymap("n", "<leader>dc", "<cmd>lua require'utils.dap-utils'.launch_or_continue()<cr>", "Continue")
customKeymap("n", "<leader>di", "<cmd>lua require'dap'.step_into()<cr>", "Step into")
customKeymap("n", "<leader>do", "<cmd>lua require'dap'.step_over()<cr>", "Step over")
customKeymap("n", "<leader>dO", "<cmd>lua require'dap'.step_out()<cr>", "Step out")
customKeymap("n", "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>", "Toggle REPL")
customKeymap("n", "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>", "Restart")
customKeymap("n", "<leader>dU", "<cmd>lua require'dapui'.toggle()<cr>", "Toggle Dap UI")
customKeymap("n", "<leader>dt", "<cmd>lua require'dap'.terminate()<cr>", "Terminate")
customKeymap("n", "<leader>du", "<cmd>lua require'dap'.up()<cr>", "Go up in stack trace")
customKeymap("n", "<leader>dd", "<cmd>lua require'dap'.down()<cr>", "Go down in stack trace")
customKeymap("n", "<leader>dR", "<cmd>lua require'dap'.run_to_cursor()<cr>", "Run to Cursor")
customKeymap("n", "<leader>dg", "<cmd>lua require'dap'.session()<cr>", "Get Session")
customKeymap("n", "<F5>", "<cmd>lua require'utils.dap-utils'.launch_or_continue()<cr>", "Continue")
customKeymap("n", "<F9>", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Toggle breakpoint")
customKeymap("n", "<F10>", "<cmd>lua require'dap'.step_over()<cr>", "Step over")
customKeymap("n", "<F11>", "<cmd>lua require'dap'.step_into()<cr>", "Step into")
customKeymap("n", "<F17>", "<cmd>lua require'dap'.terminate()<cr>", "Terminate") -- Shift-<F5>
customKeymap("n", "<F23>", "<cmd>lua require'dap'.step_out()<cr>", "Step out") -- Shift+<F11>
customKeymap("n", "<F41>", "<cmd>lua require'dap'.run_last()<cr>", "Restart") -- Ctrl+Shift+<F5>
-- customKeymap("n", "<C-k>", "<cmd>lua require('dapui').eval()<cr>", "Evaluate expression") --> defined in lua/plugins/dap.lua (keybinding only present when debugging)

-- Lsp
customKeymap("n", "<leader>lf", "<cmd>lua vim.lsp.buf.format{ async = true }<cr>", "Format file")
customKeymap("n", "<leader>lR", "<CMD>LspRestart<CR>", "Restart LSP")
customKeymap("n", "<leader>li", "<CMD>LspInfo<CR>", "LSP Info")
customKeymap("n", "<leader>lI", "<CMD>Mason<CR>", "Mason")
customKeymap(
  "n",
  "<leader>lh",
  "<cmd>lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())<cr>",
  "Toggle Inlay Hint"
)

-- Toggleterm
customKeymap("n", "<leader>t", "<cmd>:ToggleTerm<cr>", "Open Toggleterm terminal")
