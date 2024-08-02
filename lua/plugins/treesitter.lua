local M = {
  "nvim-treesitter/nvim-treesitter",
  commit = "e0d6c7643dc953acc2e817d0cebfc2f1f8c008e1",
  lazy = false,
  build = function()
      require("nvim-treesitter.install").update({ with_sync = true })()
  end,
}

function M.config()
  require("nvim-treesitter.configs").setup({
    modules = {},
    sync_install = true, -- install languages synchronously (only applied to `ensure_installed`)
    -- A list of parser names, or "all" (the listed parsers MUST always be installed)
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

    -- Automatically install missing parsers when entering buffer
    auto_install = true,

    ignore_install = {}, -- List of parsers to ignore installing

    highlight = {
      enable = true, -- false will disable the whole extension
      disable = {}, -- list of language that will be disabled
    },

    indent = {
      enable = true,
      disable = { "css" } 
    },
  })
end

return M
