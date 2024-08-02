local M = {
  "akinsho/toggleterm.nvim",
  tag = "v2.12.0",
  event = "VeryLazy",
}

function M.config()
  local status_ok, toggleterm = pcall(require, "toggleterm")
  if not status_ok then
    return
  end

  toggleterm.setup({
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

  function _G.set_terminal_keymaps()
    local opts = { noremap = true }
    -- vim.api.nvim_buf_set_keymap(0, "t", "<esc>", [[<C-\><C-n>]], opts)
    vim.api.nvim_buf_set_keymap(0, "t", "<M-h>", [[<C-\><C-n><C-W>h]], opts)
    vim.api.nvim_buf_set_keymap(0, "t", "<M-j>", [[<C-\><C-n><C-W>j]], opts)
    vim.api.nvim_buf_set_keymap(0, "t", "<M-k>", [[<C-\><C-n><C-W>k]], opts)
    vim.api.nvim_buf_set_keymap(0, "t", "<M-l>", [[<C-\><C-n><C-W>l]], opts)
    vim.api.nvim_buf_set_keymap(0, "n", "<tab>", [[<C-w><C-p>:bnext<CR>]], opts)
    vim.api.nvim_buf_set_keymap(0, "n", "<S-tab>", [[<C-w><C-p>:bprevious<CR>]], opts)

    -- Resize with arrows
    vim.api.nvim_buf_set_keymap(0, "t", "<M-Up>", "<cmd>:resize +2<CR>", opts)
    vim.api.nvim_buf_set_keymap(0, "t", "<M-Down>", "<cmd>:resize -2<CR>", opts)
    vim.api.nvim_buf_set_keymap(0, "t", "<M-Left>", "<cmd>:vertical resize -2<CR>", opts)
    vim.api.nvim_buf_set_keymap(0, "t", "<M-Right>", "<cmd>:vertical resize +2<CR>", opts)
  end

  vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

  local Terminal = require("toggleterm.terminal").Terminal
  local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })

  function _LAZYGIT_TOGGLE()
    lazygit:toggle()
  end
end

return M
