-- Properly configures lua_ls for editing this Neovim config: only the
-- plugin modules actually `require`d get loaded as workspace libraries.
require("lazydev").setup({
    library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = "luvit-meta/library", words = { "vim%.uv" } },
    },
})
