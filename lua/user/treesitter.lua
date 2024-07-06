local M = {
  "nvim-treesitter/nvim-treesitter",
  commit = "e0d6c7643dc953acc2e817d0cebfc2f1f8c008e1",
  event = "BufReadPost",
  dependencies = {
    {
      "JoosepAlviste/nvim-ts-context-commentstring",
      event = "VeryLazy",
    },
    {
      "nvim-tree/nvim-web-devicons",
      event = "VeryLazy",
    },
  },
}

function M.config()
  require("nvim-treesitter.configs").setup({
    modules = {},
    sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
    ensure_installed = {
      "bash",
      "cpp",
      "go",
      "html",
      "javascript",
      "jsonc",
      "lua",
      "markdown",
      "markdown_inline",
      "python",
      "toml",
      "typescript",
      "tsx",
      "yaml",
    },
    -- ensure_installed = "all", -- one of "all" or a list of languages

    -- Automatically install missing parsers when entering buffer
    auto_install = true,

    ignore_install = { "" }, -- List of parsers to ignore installing

    highlight = {
      enable = true, -- false will disable the whole extension
      disable = {}, -- list of language that will be disabled
    },

    autopairs = {
      enable = true,
    },

    indent = { enable = true, disable = { "css" } },

    context_commentstring = {
      enable = true,
      enable_autocmd = false,
    },
  })
end

return M
