local M = {
  "nvim-telescope/telescope.nvim",
  tag = '0.1.8',
  cmd = { "Telescope" },
  dependencies = {
    {
      'nvim-lua/plenary.nvim'
    },
  },
}

M.setup = function ()
    local actions = require("telescope.actions")
    require("telescope").setup( {
      defaults = {
        prompt_prefix = " ",
        selection_caret = " ",
        path_display = { "smart" },
        file_ignore_patterns = { ".git/", "node_modules" },
        mappings = {
          i = {
            ["<Down>"] = actions.move_selection_next,
            ["<Up>"] = actions.move_selection_previous,
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-u>"] = false, -- clear the prompt rather than scroll the previewer
          },
        },
      },
      pickers = {
        find_files = {
          hidden = false, -- shows hidden files (starting with ".")
          no_ignore = false, -- show files ignored by .gitignore, .ignore, etc.
          no_ignore_parent = false, -- show files ignored by .gitignore, .ignore, etc. in parent dirs
        },
        git_files = {
          show_untracked = true, -- shows untracked files
        },
      },
    })
end
-- Falling back to find_files if git_files can't find a .git directory
-- https://github.com/nvim-telescope/telescope.nvim/wiki/Configuration-Recipes#falling-back-to-find_files-if-git_files-cant-find-a-git-directory
--
-- We cache the results of "git rev-parse"
-- Process creation is expensive in Windows, so this reduces latency
local is_inside_work_tree = {}

M.project_files = function(opts)
  local builtin = require("telescope.builtin")

  opts = opts or {} -- define here if you want to define something

  local cwd = vim.fn.getcwd()
  if is_inside_work_tree[cwd] == nil then
    vim.fn.system("git rev-parse --is-inside-work-tree")
    is_inside_work_tree[cwd] = vim.v.shell_error == 0
  end

  if is_inside_work_tree[cwd] then
    builtin.git_files(opts)
  else
    builtin.find_files(opts)
  end
end

return M
