local M = {
  "hrsh7th/nvim-cmp",
  commit = "a110e12d0b58eefcf5b771f533fc2cf3050680ac",
  dependencies = {
    {
      "hrsh7th/cmp-nvim-lsp",
      commit = "39e2eda76828d88b773cc27a3f61d2ad782c922d",
    },
    {
      "hrsh7th/cmp-buffer",
      commit = "3022dbc9166796b644a841a02de8dd1cc1d311fa",
    },
    {
      "hrsh7th/cmp-path",
      commit = "91ff86cd9c29299a64f968ebb45846c485725f23",
    },
    {
      "hrsh7th/cmp-cmdline",
      commit = "d250c63aa13ead745e3a40f61fdd3470efde3923",
    },
    {
      "saadparwaiz1/cmp_luasnip",
      commit = "05a9ab28b53f71d1aece421ef32fee2cb857a843",
    },
    {
      "L3MON4D3/LuaSnip",
      commit = "ce0a05ab4e2839e1c48d072c5236cce846a387bc",
      event = "InsertEnter",
      dependencies = {
        "rafamadriz/friendly-snippets",
        commit = "682157939e57bd6a2c86277dfd4d6fbfce63dbac",
      },
    },
    {
      "hrsh7th/cmp-nvim-lua",
      commit = "f12408bdb54c39c23e67cab726264c10db33ada8",
    },
  },
  event = {
    "InsertEnter",
    "CmdlineEnter",
  },
}

function M.config()
  local cmp = require("cmp")
  local luasnip = require("luasnip")
  require("luasnip/loaders/from_vscode").lazy_load()

  local check_backspace = function()
    local col = vim.fn.col(".") - 1
    return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
  end

  -- used to format the completion text (using icons instead of text)
  local kind_icons = {
    Text = "󰉿",
    Method = "m",
    Function = "󰊕",
    Constructor = "",
    Field = "",
    Variable = "󰆧",
    Class = "󰌗",
    Interface = "",
    Module = "",
    Property = "",
    Unit = "",
    Value = "󰎠",
    Enum = "",
    Keyword = "󰌋",
    Snippet = "",
    Color = "󰏘",
    File = "󰈙",
    Reference = "",
    Folder = "󰉋",
    EnumMember = "",
    Constant = "󰇽",
    Struct = "",
    Event = "",
    Operator = "󰆕",
    TypeParameter = "󰊄",
    Codeium = "󰚩",
    Copilot = "",
  }

  cmp.setup({
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body) -- For `luasnip` users.
      end,
    },
    mapping = cmp.mapping.preset.insert({
      ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
      ["<C-e>"] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      -- Accept currently selected item. If none selected, `select` first item.
      -- Set `select` to `false` to only confirm explicitly selected items.
      ["<CR>"] = cmp.mapping.confirm({ select = false }),
      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expandable() then
          luasnip.expand()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        elseif check_backspace() then
          fallback()
        else
          fallback()
        end
      end, {
        "i",
        "s",
      }),
      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, {
        "i",
        "s",
      }),
    }),
    -- formatting = {
    --   expandable_indicator = true,
    --   fields = { "kind", "abbr", "menu" },
    --   format = function(entry, vim_item)
    --     vim_item.kind = kind_icons[vim_item.kind]
    --     vim_item.menu = ({
    --       nvim_lsp = "",
    --       nvim_lua = "",
    --       luasnip = "",
    --       buffer = "",
    --       path = "",
    --       emoji = "",
    --     })[entry.source.name]
    --     return vim_item
    --   end,
    -- },
    sources = {
      { name = "nvim_lsp" },
      { name = "nvim_lua" },
      { name = "luasnip" },
      { name = "buffer" },
      { name = "path" },
    },
    confirm_opts = {
      behavior = cmp.ConfirmBehavior.Replace,
      select = false,
    },
    window = {
      -- showing box around window
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    experimental = {
      ghost_text = true,
    },
  })
end

return M
