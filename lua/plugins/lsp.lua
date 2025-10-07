local M = {
  "neovim/nvim-lspconfig",
  lazy = false,
  dependencies = {
    {
      "hrsh7th/cmp-nvim-lsp", -- nvim-cmp source for neovim's built-in language server client
      commit = "bd5a7d6"
    },
    {
      "williamboman/mason.nvim",
    },
    {
      "lukas-reineke/lsp-format.nvim",
    }
  },
  config = function()
    -- INFO: read filenames on lsp/ directory and enable those
    local lsp_files = {}
    local lsp_dir = vim.fn.stdpath("config") .. "/lsp/"

    for _, file in ipairs(vim.fn.globpath(lsp_dir, "*.lua", false, true)) do
      -- Read the first line of the file
      local f = io.open(file, "r")
      local first_line = f and f:read("*l") or ""
      if f then
        f:close()
      end

      -- Only include the file if it doesn't start with "-- disable"
      if not first_line:match("^%-%- disable") then
        local name = vim.fn.fnamemodify(file, ":t:r") -- `:t` gets filename, `:r` removes extension
        table.insert(lsp_files, name)
      end
    end

    vim.lsp.enable(lsp_files)

    -- local capabilities =
    --     vim.tbl_deep_extend("force", vim.lsp.protocol.make_client_capabilities(),
    --       require("cmp_nvim_lsp").default_capabilities())
    -- capabilities.textDocument.semanticTokens.multilineTokenSupport = true

    vim.lsp.config("*", {
      -- capabilities = capabilities,
    })

    local config = {
      -- disable virtual text
      virtual_text = false,
      -- show signs
      signs = {
        text = {
          [vim.diagnostic.severity.HINT] = " ",
          [vim.diagnostic.severity.INFO] = " ",
          [vim.diagnostic.severity.WARN] = " ",
          [vim.diagnostic.severity.ERROR] = " ",
        },
      },
      update_in_insert = true,
      underline = true,
      severity_sort = true,
      float = {
        focusable = true,
        style = "minimal",
        border = "rounded",
        source = true,
        header = "",
        prefix = "",
      },
    }

    vim.diagnostic.config(config)
  end
}

return M
