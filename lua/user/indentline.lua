local M = {
  "lukas-reineke/indent-blankline.nvim",
  commit = "65e20ab94a26d0e14acac5049b8641336819dfc7",
  event = "BufReadPre",
}

function M.config()
  require("ibl").setup({
    -- indent = { char = "|" },
    scope = { enabled = true },
    exclude = {
      -- buftypes = { "terminal", "nofile", "quickfix", "prompt" }
      filetypes = {
        "lspinfo",
        "packer",
        "checkhealth",
        "help",
        "man",
        "gitcommit",
        "TelescopePrompt",
        "TelescopeResults",
        "''",
        "NvimTree",
      },
    },
  })
end
return M
