local augroup = vim.api.nvim_create_augroup

-- Briefly highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("highlight-yank", { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- make all windows the same height & width on each tab on VimResized
vim.api.nvim_create_autocmd({ "VimResized" }, {
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
})

-- Close simple utility buffers with `q`
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("close-with-q", { clear = true }),
  pattern = { "help", "man", "qf", "checkhealth", "lspinfo" },
  callback = function(args)
    vim.bo[args.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = args.buf, silent = true })
  end,
})

-- Wrap and spell-check prose
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("wrap-prose", { clear = true }),
  pattern = { "markdown", "gitcommit" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
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
  pattern = { "python", "ps1" },
  callback = function()
    vim.cmd("setlocal shiftwidth=4")
  end,
})

-- LSP: buffer-local keymaps and behaviour once a server attaches
vim.api.nvim_create_autocmd("LspAttach", {
  group = augroup("lsp-attach", { clear = true }),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client then
      return
    end

    local function map(keys, func, desc)
      vim.keymap.set("n", keys, func, { buffer = args.buf, desc = "LSP: " .. desc })
    end

    map("gd", vim.lsp.buf.definition, "Goto definition")
    map("gD", vim.lsp.buf.declaration, "Goto declaration")
    map("gI", vim.lsp.buf.implementation, "List implementations")
    map("gr", vim.lsp.buf.references, "List references")
    map("gl", vim.diagnostic.open_float, "Open diagnostics float")
    map("<leader>lr", vim.lsp.buf.rename, "Rename")
    map("<leader>la", vim.lsp.buf.code_action, "Code action")
    map("<leader>lf", function()
      vim.lsp.buf.format({ async = true })
    end, "Format buffer")
    map("<leader>lj", function()
      vim.diagnostic.jump({ count = 1, float = true })
    end, "Move to next diagnostic")
    map("<leader>lk", function()
      vim.diagnostic.jump({ count = -1, float = true })
    end, "Move to previous diagnostic")
    map("<leader>lr", vim.lsp.buf.rename, "Rename")
    map("<F2>", vim.lsp.buf.rename, "Rename")

    if client:supports_method("textDocument/inlayHint") then
      vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
      map("<leader>lh", function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = args.buf }), { bufnr = args.buf })
      end, "Toggle inlay hints")
    end

    if client:supports_method("textDocument/formatting") then
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup("lsp-format-" .. args.buf, { clear = true }),
        buffer = args.buf,
        callback = function()
          vim.lsp.buf.format({ bufnr = args.buf, async = false })
        end,
      })
    end
  end,
})
