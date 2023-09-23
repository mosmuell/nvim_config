local customKeymap = require("utils.customKeymap").customKeymap

--Remap space as leader key
customKeymap("", "<Space>", "<Nop>", "Leader key")

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
customKeymap("n", "<M-h>", "<C-w>h", "Navigate to the left split")
customKeymap("n", "<M-j>", "<C-w>j", "Navigate to the bottom split")
customKeymap("n", "<M-k>", "<C-w>k", "Navigate to the top split")
customKeymap("n", "<M-l>", "<C-w>l", "Navigate to the right split")

-- Resize with arrows
customKeymap("n", "<M-Up>", ":resize -2<CR>", "Shrink window horizontally")
customKeymap("n", "<M-Down>", ":resize +2<CR>", "Increase window horizontally")
customKeymap("n", "<M-Left>", ":vertical resize -2<CR>", "Shrink window vertically")
customKeymap("n", "<M-Right>", ":vertical resize +2<CR>", "Increase window vertically")

-- -- Resize with arrows
-- keymap("n", "<M-Up>", '<cmd>lua require("tmux").resize_top()<cr>', opts)
-- keymap("n", "<M-Down>", '<cmd>lua require("tmux").resize_bottom()<cr>', opts)
-- keymap("n", "<M-Left>", '<cmd>lua require("tmux").resize_left()<cr>', opts)
-- keymap("n", "<M-Right>", '<cmd>lua require("tmux").resize_right()<cr>', opts)

-- Navigate buffers
customKeymap("n", "<Tab>", ":bnext<CR>", "Next buffer")
customKeymap("n", "<S-Tab>", ":bprevious<CR>", "Previous buffer")
customKeymap("n", "<S-l>", ":bnext<CR>", "Next buffer")
customKeymap("n", "<S-h>", ":bprevious<CR>", "Previous buffer")

-- Clear highlights
customKeymap("n", "<leader>h", "<cmd>nohlsearch<CR>", "Clear highlights")

-- Close buffer
customKeymap("n", "<A-q>", "<cmd>Bdelete!<CR>", "Close buffer")

-- Better paste
customKeymap("v", "p", "P", "Better paste")

-- Insert --
-- Press jk fast to enter
customKeymap("i", "jk", "<ESC>", "Better escape")

-- Visual --
-- Stay in indent mode
customKeymap("v", "<", "<gv", "Indent to the left")
customKeymap("v", ">", ">gv", "Indent to the right")

-- Plugins --

-- NvimTree
customKeymap("n", "<leader>e", ":NvimTreeToggle<CR>", "Toggle explorer")
customKeymap("n", "<C-n>", ":NvimTreeToggle<CR>", "Toggle explorer")

-- Telescope
customKeymap("n", "<leader>f", "", "Find files")
customKeymap("n", "<leader>ff", ":Telescope find_files<CR>", "Find files")
customKeymap("n", "<leader>ft", ":Telescope live_grep<CR>", "Find words")
customKeymap("n", "<leader>fp", ":Telescope projects<CR>", "Find projects")
customKeymap("n", "<leader>fb", ":Telescope buffers<CR>", "Find buffers")

-- Git
customKeymap("n", "<leader>gg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", "Lazygit")
customKeymap("n", "<leader>gl", "<cmd>lua require('gitsigns').blame_line()<cr>", "View Git blame")
customKeymap("n", "<leader>gL", "<cmd>lua require('gitsigns').blame_line { full = true }<cr>", "View full Git blame")
customKeymap("n", "<leader>gp", "<cmd>lua require('gitsigns').preview_hunk()<cr>", "Preview Git hunk")
customKeymap("n", "<leader>gh", "<cmd>lua require('gitsigns').reset_hunk()<cr>", "Reset Git hunk")
customKeymap("n", "<leader>gr", "<cmd>lua require('gitsigns').reset_buffer()<cr>", "Reset Git buffer")
customKeymap("n", "<leader>gs", "<cmd>lua require('gitsigns').stage_hunk()<cr>", "Stage Git hunk")
customKeymap("n", "<leader>gS", "<cmd>lua require('gitsigns').stage_buffer()<cr>", "Stage Git buffer")
customKeymap("n", "<leader>gu", "<cmd>lua require('gitsigns').undo_stage_hunk()<cr>", "Unstage Git hunk")
customKeymap("n", "<leader>gd", "<cmd>lua require('gitsigns').diffthis()<cr>", "View Git diff")
customKeymap("n", "]g", "<cmd>lua require('gitsigns').next_hunk()", "Next Git hunk")
customKeymap("n", "[g", "<cmd>lua require('gitsigns').prev_hunk()<cr>", "Previous Git hunk")

-- Comment
customKeymap("n", "<leader>/", "<cmd>lua require('Comment.api').toggle.linewise.current()<CR>", "Toggle comment line")
customKeymap(
  "x",
  "<leader>/",
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
customKeymap("n", "<leader>dc", "<cmd>lua require'dap'.continue()<cr>", "Continue")
customKeymap("n", "<leader>di", "<cmd>lua require'dap'.step_into()<cr>", "Step into")
customKeymap("n", "<leader>do", "<cmd>lua require'dap'.step_over()<cr>", "Step over")
customKeymap("n", "<leader>dO", "<cmd>lua require'dap'.step_out()<cr>", "Step out")
customKeymap("n", "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>", "Toggle REPL")
customKeymap("n", "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>", "Run last")
customKeymap("n", "<leader>du", "<cmd>lua require'dapui'.toggle()<cr>", "Toggle Dap UI")
customKeymap("n", "<leader>dt", "<cmd>lua require'dap'.terminate()<cr>", "Terminate")

-- Lsp
customKeymap("n", "<leader>lf", "<cmd>lua vim.lsp.buf.format{ async = true }<cr>", "Format file")
