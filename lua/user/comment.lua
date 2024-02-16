local M = {
  "numToStr/Comment.nvim",
  commit = "eab2c83a0207369900e92783f56990808082eac2",
  event = { "BufRead", "BufNewFile" },
  dependencies = {
    {
      "JoosepAlviste/nvim-ts-context-commentstring",
      event = "VeryLazy",
      commit = "92e688f013c69f90c9bbd596019ec10235bc51de",
    },
  },
}

function M.config()
  local comment = require "Comment"
  comment.setup {
    pre_hook = function(ctx)
      -- Only calculate commentstring for tsx filetypes
      if vim.bo.filetype == "typescriptreact" then
        local U = require "Comment.utils"

        -- Determine whether to use linewise or blockwise commentstring
        local type = ctx.ctype == U.ctype.linewise and "__default" or "__multiline"

        -- Determine the location where to calculate commentstring from
        local location = nil
        if ctx.ctype == U.ctype.blockwise then
          location = require("ts_context_commentstring.utils").get_cursor_location()
        elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
          location = require("ts_context_commentstring.utils").get_visual_start_location()
        end

        return require("ts_context_commentstring.internal").calculate_commentstring {
          key = type,
          location = location,
        }
      end
    end,
    mappings = false,
  }
end

return M
