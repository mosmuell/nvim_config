require("toggleterm").setup({
  size = 20,
  open_mapping = [[<c-\>]],
  hide_numbers = true,
  shade_terminals = true,
  shading_factor = 2,
  start_in_insert = true,
  insert_mappings = true,
  persist_size = true,
  direction = "float",
  close_on_exit = true,
  shell = vim.o.shell,
  float_opts = {
    border = "curved",
    winblend = 0,
    highlights = {
      border = "Normal",
      background = "Normal",
    },
  },
})

vim.api.nvim_create_autocmd("TermOpen", {
  group = vim.api.nvim_create_augroup("toggleterm-keymaps", { clear = true }),
  pattern = "term://*",
  callback = function(args)
    local opts = { buffer = args.buf, noremap = true }

    vim.keymap.set("t", "<M-h>", [[<C-\><C-n><C-W>h]], opts)
    vim.keymap.set("t", "<M-j>", [[<C-\><C-n><C-W>j]], opts)
    vim.keymap.set("t", "<M-k>", [[<C-\><C-n><C-W>k]], opts)
    vim.keymap.set("t", "<M-l>", [[<C-\><C-n><C-W>l]], opts)
    vim.keymap.set("n", "<Tab>", [[<C-w><C-p>:bnext<CR>]], opts)
    vim.keymap.set("n", "<S-Tab>", [[<C-w><C-p>:bprevious<CR>]], opts)

    -- Resize with arrows
    vim.keymap.set("t", "<M-Up>", "<cmd>resize +2<CR>", opts)
    vim.keymap.set("t", "<M-Down>", "<cmd>resize -2<CR>", opts)
    vim.keymap.set("t", "<M-Left>", "<cmd>vertical resize -2<CR>", opts)
    vim.keymap.set("t", "<M-Right>", "<cmd>vertical resize +2<CR>", opts)
  end,
})

local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })

local M = {}

function M.lazygit_toggle()
  lazygit:toggle()
end

return M
