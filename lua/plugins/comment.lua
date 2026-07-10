require("ts_context_commentstring").setup({
  enable_autocmd = false,
})

---@diagnostic disable-next-line: missing-fields
require("Comment").setup({
  -- Only calculate a context-aware commentstring for tsx filetypes, where
  -- a single file mixes JS/TS `//` comments with JSX `{/* */}` comments.
  pre_hook = function(ctx)
    if vim.bo.filetype ~= "typescriptreact" then
      ---@diagnostic disable-next-line: missing-return-value
      return
    end

    local U = require("Comment.utils")
    local key = ctx.ctype == U.ctype.linewise and "__default" or "__multiline"

    local location = nil
    if ctx.ctype == U.ctype.blockwise then
      location = require("ts_context_commentstring.utils").get_cursor_location()
    elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
      location = require("ts_context_commentstring.utils").get_visual_start_location()
    end

    ---@diagnostic disable-next-line: return-type-mismatch
    return require("ts_context_commentstring.internal").calculate_commentstring({
      key = key,
      ---@diagnostic disable-next-line: assign-type-mismatch
      location = location,
    })
  end,
  padding = true,
  sticky = true,
  -- Leave `gc`/`gcc` on Neovim's own built-in comment implementation;
  -- <leader>/ (see keymaps.lua) is the only thing that goes through
  -- Comment.nvim's API, so it's the only path that gets the pre_hook above.
  mappings = false,
})
