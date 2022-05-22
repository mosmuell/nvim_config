local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
keymap("n", "<M-h>", "<C-w>h", opts)
keymap("n", "<M-j>", "<C-w>j", opts)
keymap("n", "<M-k>", "<C-w>k", opts)
keymap("n", "<M-l>", "<C-w>l", opts)

-- Custom navigator bindings (as set in tmux)
keymap("n", "<M-h>", '<cmd>lua require("tmux").move_left()<cr>', opts)
keymap("n", "<M-j>", '<cmd>lua require("tmux").move_bottom()<cr>', opts)
keymap("n", "<M-k>", '<cmd>lua require("tmux").move_top()<cr>', opts)
keymap("n", "<M-l>", '<cmd>lua require("tmux").move_right()<cr>', opts)

-- Resize with arrows
keymap("n", "<M-Up>", '<cmd>lua require("tmux").resize_top()<cr>', opts)
keymap("n", "<M-Down>", '<cmd>lua require("tmux").resize_bottom()<cr>', opts)
keymap("n", "<M-Left>", '<cmd>lua require("tmux").resize_left()<cr>', opts)
keymap("n", "<M-Right>", '<cmd>lua require("tmux").resize_right()<cr>', opts)

-- Navigate buffers
keymap("n", "<Tab>", ":bnext<CR>", opts)
keymap("n", "<S-Tab>", ":bprevious<CR>", opts)
keymap("n", "<M-1>", "<Cmd>BufferLineGoToBuffer 1<CR>", opts)
keymap("n", "<M-2>", "<Cmd>BufferLineGoToBuffer 2<CR>", opts)
keymap("n", "<M-3>", "<Cmd>BufferLineGoToBuffer 3<CR>", opts)
keymap("n", "<M-4>", "<Cmd>BufferLineGoToBuffer 4<CR>", opts)
keymap("n", "<M-5>", "<Cmd>BufferLineGoToBuffer 5<CR>", opts)
keymap("n", "<M-6>", "<Cmd>BufferLineGoToBuffer 6<CR>", opts)
keymap("n", "<M-7>", "<Cmd>BufferLineGoToBuffer 7<CR>", opts)
keymap("n", "<M-8>", "<Cmd>BufferLineGoToBuffer 8<CR>", opts)
keymap("n", "<M-9>", "<Cmd>BufferLineGoToBuffer 9<CR>", opts)
keymap("n", "<M-0>", "<Cmd>BufferLineGoToBuffer 0<CR>", opts)

-- Closing current buffer
keymap("n", "<M-q>", ":Bdelete <CR>", opts)
keymap("n", "<M-S-q>", ":Bdelete! <CR>", opts)

-- Toggling nvim-tree
keymap("n", "<C-n>", ":NvimTreeToggle<CR>", opts)

-- Commenting out current line
keymap("n", "<C-_>", '<CMD>lua require("Comment.api").toggle_current_linewise()<CR>', opts)

-- Insert --
-- Press jk fast to enter
keymap("i", "jk", "<ESC>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts)

-- Commenting out current block
keymap("v", "<C-_>", '<ESC><CMD>lua require("Comment.api").toggle_linewise_op(vim.fn.visualmode())<CR>', opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Terminal --
-- Better terminal navigation
keymap("t", "<M-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<M-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<M-k>", "<C-\\><C-N><C-w>k", term_opts)
keymap("t", "<M-l>", "<C-\\><C-N><C-w>l", term_opts)


-- nvim dap --
keymap("n", "<F5>", "<CMD>lua require'dap'.continue()<CR>", opts)
keymap("n", "<F10>", "<CMD>lua require'dap'.step_over()<CR>", opts)
keymap("n", "<F11>", "<CMD>lua require'dap'.step_into()<CR>", opts)
keymap("n", "<F12>", "<CMD>lua require'dap'.step_out()<CR>", opts)
-- keymap("n", "<leader>db", "lua require'dap'.toggle_breakpoint()<CR>", opts)
-- keymap("n", "<leader>dB", "lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", opts)
-- keymap("n", "<leader>dr", "lua require'dap'.repl.open()<CR>", opts)
-- keymap("n", "<leader>dl", "lua require'dap'.run_last()<CR>", opts)
