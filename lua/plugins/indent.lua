require("ibl").setup({
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
