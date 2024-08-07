local M = {
  "folke/tokyonight.nvim",
  commit = "e52c41314e83232840d6970e6b072f9fba242eb9",
  lazy = false, -- make sure we load this during startup if it is your main colorscheme
  priority = 1000, -- make sure to load this before all the other start plugins
  dependencies = {
    {
      "lunarvim/darkplus.nvim",
      commit = "c7fff5ce62406121fc6c9e4746f118b2b2499c4c",
    },
  },
}

M.name = "darkplus"
function M.config()
  local status_ok, _ = pcall(vim.cmd.colorscheme, M.name)

  if not status_ok then
    return
  end

  -- Defining the Group colours manually
  -- You can use `:Inspect` to show the highlight groups under the cursor
  local hl = vim.api.nvim_set_hl
  hl(0, "Directory", { fg = "#42a5f5", bg = "NONE" })
  hl(0, "NvimTreeOpenedFolderName", { fg = "#42a5f5", bg = "NONE", bold = true, italic = true })

  if M.name == "darkplus" then
    hl(0, "@keyword.import", { link = "Include" })
    hl(0, "@attribute.builtin.python", { link = "PreProc" })
    hl(0, "@keyword.coroutine.python", { link = "Keyword" })
  end
end

return M
