local ok = pcall(vim.cmd.colorscheme, "darkplus")
if not ok then
  return
end

-- Use `:Inspect` to find the highlight group under the cursor.
local hl = vim.api.nvim_set_hl
hl(0, "Directory", { fg = "#42a5f5", bg = "NONE" })
hl(0, "NvimTreeOpenedFolderName", { fg = "#42a5f5", bg = "NONE", bold = true, italic = true })
hl(0, "@keyword.import", { link = "Include" })
hl(0, "@attribute.builtin.python", { link = "PreProc" })
hl(0, "@keyword.coroutine.python", { link = "Keyword" })
