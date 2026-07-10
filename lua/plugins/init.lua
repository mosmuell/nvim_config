local is_linux = vim.fn.has("linux") == 1

-- Plugin specs, listed in dependency order (libraries first, consumers
-- after). `load = true` sources every plugin's `plugin/` and `ftdetect/`
-- scripts immediately, in this same order, so startup behaves the same
-- way every time regardless of when `vim.pack.add()` happens to run.
local specs = {
  -- Colorscheme: set before anything else so every other plugin's
  -- highlight groups are created on top of it, not the reverse.
  { src = "https://github.com/lunarvim/darkplus.nvim",                     version = "c7fff5ce62406121fc6c9e4746f118b2b2499c4c" },

  -- Libraries other plugins below depend on
  { src = "https://github.com/nvim-lua/plenary.nvim" },
  { src = "https://github.com/nvim-tree/nvim-web-devicons" },

  -- Syntax / parsing
  { src = "https://github.com/nvim-treesitter/nvim-treesitter" },

  -- LSP tooling
  { src = "https://github.com/mason-org/mason.nvim" },
  { src = "https://github.com/j-hui/fidget.nvim" },
  { src = "https://github.com/Bilal2453/luvit-meta" }, -- optional `vim.uv` typings
  { src = "https://github.com/folke/lazydev.nvim" },

  -- Completion, and the snippet engine it expands LSP snippets with
  { src = "https://github.com/L3MON4D3/LuaSnip" },
  { src = "https://github.com/hrsh7th/cmp-nvim-lsp" },
  { src = "https://github.com/hrsh7th/cmp-nvim-lua" },
  { src = "https://github.com/hrsh7th/cmp-buffer" },
  { src = "https://github.com/hrsh7th/cmp-path" },
  { src = "https://github.com/hrsh7th/cmp-nvim-lsp-signature-help" },
  { src = "https://github.com/hrsh7th/cmp-cmdline" },
  { src = "https://github.com/saadparwaiz1/cmp_luasnip" },
  { src = "https://github.com/hrsh7th/nvim-cmp" },

  -- Git
  { src = "https://github.com/lewis6991/gitsigns.nvim" },

  -- Editing
  { src = "https://github.com/JoosepAlviste/nvim-ts-context-commentstring" },
  { src = "https://github.com/numToStr/Comment.nvim",                      version = "e30b7f2008e52442154b66f7c519bfd2f1e32acb" },
  { src = "https://github.com/RRethy/vim-illuminate" },

  -- UI
  { src = "https://github.com/nvim-lualine/lualine.nvim",                  version = "b8c2315" },
  { src = "https://github.com/lukas-reineke/indent-blankline.nvim" },
  { src = "https://github.com/nvim-tree/nvim-tree.lua" },
  { src = "https://github.com/nvim-telescope/telescope.nvim" },
  { src = "https://github.com/akinsho/toggleterm.nvim",                    version = "9a88eae" },
}

-- tmux.nvim shells out to `tmux`, which isn't available on Windows/macOS
-- setups this config also runs on.
if is_linux then
  table.insert(specs, { src = "https://github.com/aserowy/tmux.nvim", version = "2c1c3be" })
end

table.insert(specs, { src = "https://github.com/folke/which-key.nvim" })

vim.pack.add(specs, { load = true })

-- Configure each plugin, in the same order they were declared above.
require("plugins.colorscheme")
require("plugins.treesitter")
require("plugins.mason")
require("plugins.fidget")
require("plugins.lazydev")
require("plugins.cmp")
require("plugins.gitsigns")
require("plugins.comment")
require("plugins.illuminate")
require("plugins.lualine")
require("plugins.indent")
require("plugins.nvim-tree")
require("plugins.telescope")
require("plugins.toggleterm")
if is_linux then
  require("plugins.tmux")
end
require("plugins.which-key")
