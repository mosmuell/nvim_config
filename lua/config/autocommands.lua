-- Close certain pages (like help or man pages) by pressing 'q'
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "qf", "help", "man", "lspinfo", "spectre_panel" },
  callback = function()
    vim.cmd([[
      nnoremap <silent> <buffer> q :close<CR> 
      set nobuflisted 
    ]])
  end,
})

-- display lines as one long line when in gitcommit or markdown
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
  end,
})

-- Automatically close tab/vim when nvim-tree is the last window in the tab
-- vim.cmd("autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif")

-- make all windows the same height & width on each tab on VimResized
vim.api.nvim_create_autocmd({ "VimResized" }, {
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
})

-- Highlight yanked selection for 200 ms
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  callback = function()
    vim.highlight.on_yank({ higroup = "Visual", timeout = 200 })
  end,
})

-- Setting shiftwidth based on file types
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "cpp", "c", "javascript", "javascriptreact", "typescript", "typescriptreact", "lua", "markdown" },
  callback = function()
    vim.cmd("setlocal shiftwidth=2")
  end,
})
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "python" },
  callback = function()
    vim.cmd("setlocal shiftwidth=4")
  end,
})

-- Enabling autoformat for certain file types
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*.py", "*.lua", "*.tsx", "*.ts", "*.go" },
  callback = function()
    vim.lsp.buf.format()
  end,
})

-- Unfold everything
-- vim.api.nvim_create_autocmd({ "BufEnter" }, {
--   pattern = { "*" },
--   callback = function()
--     vim.cmd("normal zR")
--   end,
-- })
