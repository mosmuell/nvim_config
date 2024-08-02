--[[ 
nvim-lspconfig is a collection of community-contributed configurations for the
built-in language server client in Nvim core. This plugin provides four
primary functionalities:

 - default launch commands, initialization options, and settings for each
   server
 - a root directory resolver which attempts to detect the root of your project
 - an autocommand mapping that either launches a new language server or
   attempts to attach a language server to each opened buffer if it falls
   under a tracked project
 - utility commands such as LspInfo, LspStart, LspStop, and LspRestart for
   managing language server instances
]]

local M = {
  "neovim/nvim-lspconfig",
  commit = "e9b1c95d29ca9e479fc39896b31d24eed96b40a3",
  lazy = false,
  dependencies = {
    {
      "hrsh7th/cmp-nvim-lsp", -- nvim-cmp source for neovim's built-in language server client
    },
  },
}

M.lsp_servers = {
  "ansiblels",
  "bashls",
  "clangd",
  "cssls",
  "eslint",
  -- "gopls",
  "html",
  "jsonls",
  "lua_ls",
  "pyright",
  "ruff",
  "tsserver",
  "yamlls",
}

function M.config()
  local lspconfig = require("lspconfig")
  local cmp_nvim_lsp = require("cmp_nvim_lsp")

  local capabilities =
    vim.tbl_deep_extend("force", vim.lsp.protocol.make_client_capabilities(), cmp_nvim_lsp.default_capabilities())
  capabilities.textDocument.completion.completionItem.snippetSupport = true

  local lsp_keymaps = function(bufnr)
    local opts = { noremap = true, silent = true }
    local keymap = vim.api.nvim_buf_set_keymap
    keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
    keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
    keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
    keymap(bufnr, "n", "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
    keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
    keymap(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
    keymap(bufnr, "n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
    keymap(bufnr, "n", "<leader>lj", "<cmd>lua vim.diagnostic.goto_next({buffer=0})<cr>", opts)
    keymap(bufnr, "n", "<leader>lk", "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>", opts)
    keymap(bufnr, "n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
    keymap(bufnr, "n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
    keymap(bufnr, "n", "<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
    keymap(bufnr, "n", "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
  end

  local on_attach = function(client, bufnr)
    -- enable inlay hints
    if vim.lsp.inlay_hint then
      vim.lsp.inlay_hint.enable(true, { 0 })
    end

    if client.name == "tsserver" then
      client.server_capabilities.documentFormattingProvider = false -- do not format with tsserver
    elseif client.name == "eslint" then
      client.server_capabilities.documentFormattingProvider = true
    end
    lsp_keymaps(bufnr)

    -- refresh codelens on TextChanged and InsertLeave as well
    vim.api.nvim_create_autocmd({ "TextChanged", "InsertLeave" }, {
      buffer = bufnr,
      callback = function()
        if client.supports_method("textDocument/codeLens") then
          vim.lsp.codelens.refresh({ bufnr = bufnr })
        end
      end,
    })
  end

  for _, server in pairs(M.lsp_servers) do
    local opts = {
      on_attach = on_attach,
      capabilities = capabilities,
    }

    server = vim.split(server, "@")[1]

    local require_ok, conf_opts = pcall(require, "config.lsp_servers." .. server)
    if require_ok then
      opts = vim.tbl_deep_extend("force", conf_opts, opts)
    end

    lspconfig[server].setup(opts)
  end

  local signs = {
    { name = "DiagnosticSignError", text = "" },
    { name = "DiagnosticSignWarn", text = "" },
    { name = "DiagnosticSignHint", text = "" },
    { name = "DiagnosticSignInfo", text = "" },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
  end

  local config = {
    -- disable virtual text
    virtual_text = false,
    -- show signs
    signs = {
      active = signs,
    },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
      focusable = false,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
      suffix = "",
    },
  }

  vim.diagnostic.config(config)

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
  })

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
  })
end

return M
