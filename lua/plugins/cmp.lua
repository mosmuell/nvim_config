local M = {
  "hrsh7th/nvim-cmp",
  commit = "a110e12d0b58eefcf5b771f533fc2cf3050680ac",
  event = {
    "InsertEnter",
    "CmdlineEnter",
  },
  dependencies = {
    {
      "hrsh7th/cmp-nvim-lsp", -- language server completion candidates
    },
    {
      "hrsh7th/cmp-buffer", -- source for words of the current buffer
    },
    {
      "hrsh7th/cmp-path", -- source for filesystem paths
    },
    {
      "hrsh7th/cmp-nvim-lua", -- source for neovim Lua API
    },
    {
      "hrsh7th/cmp-nvim-lsp-signature-help", -- source for displaying function signatures with the current parameter emphasized
    },
    {
      "hrsh7th/cmp-cmdline",
    },
    {
      "saadparwaiz1/cmp_luasnip",
      commit = "05a9ab28b53f71d1aece421ef32fee2cb857a843",
    },
    {
      "L3MON4D3/LuaSnip",
      commit = "7552e6504ee95a9c8cfc6db53e389122ded46cd4",
      dependencies = {
        "rafamadriz/friendly-snippets",
        commit = "00ebcaa159e817150bd83bfe2d51fa3b3377d5c4",
      },
    },
  },
}

function M.config()
  local cmp = require("cmp")
  local luasnip = require("luasnip")

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
        -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        -- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
      end,
    },
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ["<C-b>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-Space>"] = cmp.mapping.complete(),
      -- ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
      ["<C-e>"] = cmp.mapping.abort(),
      -- ["<C-e>"] = cmp.mapping({
      --   i = cmp.mapping.abort(),
      --   c = cmp.mapping.close(),
      -- }),
      -- Accept currently selected item. If none selected, `select` first item.
      -- Set `select` to `false` to only confirm explicitly selected items.
      ["<CR>"] = cmp.mapping.confirm({ select = false }),
      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.locally_jumpable(1) then
          luasnip.jump(1)
        else
          fallback()
        end
      end, { "i", "s" }),
      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.locally_jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { "i", "s" }),
    }),
    sources = cmp.config.sources({
      { name = "nvim_lsp" },
      { name = "nvim_lua" },
      { name = "buffer" },
      {
        name = "path",
        option = {
          trailing_slash = true,
        },
      },
      { name = "nvim_lsp_signature_help" },
      {
        name = "lazydev",
        group_index = 0, -- set group index to 0 to skip loading LuaLS completions
      },
      { name = "luasnip" }, -- For luasnip users.
      -- { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {}),
  })

  -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline({ "/", "?" }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = "buffer" },
    },
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      {
        name = "path",
        option = {
          trailing_slash = true,
        },
      },
      {
        name = "cmdline",
        option = {
          treat_trailing_slash = false,
        },
      },
    }),
    matching = { disallow_symbol_nonprefix_matching = false },
  })
end

return M
