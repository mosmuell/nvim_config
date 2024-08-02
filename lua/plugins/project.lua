local M = {
  "ahmedkhalf/project.nvim",
  commit = "8c6bad7d22eef1b71144b401c9f74ed01526a4fb",
  event = "VeryLazy",
  dependencies = {
    {
      "nvim-telescope/telescope.nvim",
    },
  },
}

function M.config()
  local project = require("project_nvim")
  project.setup({
    -- Methods of detecting the root directory. **"lsp"** uses the native neovim
    -- lsp, while **"pattern"** uses vim-rooter like glob pattern matching. Here
    -- order matters: if one is not detected, the other is used as fallback. You
    -- can also delete or rearangne the detection methods.
    detection_methods = { "pattern", "lsp" },
    -- detection_methods = { "pattern" }, -- NOTE: lsp detection will get annoying with multiple langs in one project

    -- patterns used to detect root dir, when **"pattern"** is in detection_methods
    patterns = { ".git", "Makefile" },
  })

  local telescope = require("telescope")
  telescope.load_extension("projects")
end

return M
