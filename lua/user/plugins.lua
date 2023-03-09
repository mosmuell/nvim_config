local fn = vim.fn
-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system { "git", "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    }
    print "Installing packer close and reopen Neovim..."
    vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
  autocmd!
  autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

-- Have packer use a popup window
packer.init {
    display = {
        open_fn = function()
            return require("packer.util").float { border = "rounded" }
        end,
    },
}

-- Install your plugins here
return packer.startup(function(use)
    -- My plugins here
    use "wbthomason/packer.nvim" -- Have packer manage itself
    use "nvim-lua/plenary.nvim"  -- Useful lua functions used ny lots of plugins
    use "windwp/nvim-autopairs"  -- Autopairs, integrates with both cmp and treesitter
    use "numToStr/Comment.nvim"
    use "kyazdani42/nvim-web-devicons"
    use { "kyazdani42/nvim-tree.lua" }
    use "akinsho/bufferline.nvim"
    use "moll/vim-bbye"
    use "nvim-lualine/lualine.nvim"
    use "akinsho/toggleterm.nvim"
    use "ahmedkhalf/project.nvim"
    use "lewis6991/impatient.nvim"
    use "lukas-reineke/indent-blankline.nvim"
    -- use "goolord/alpha-nvim"
    use "folke/which-key.nvim"

    -- Colorschemes
    -- use "lunarvim/colorschemes" -- A bunch of colorschemes you can try out
    -- use "lunarvim/darkplus.nvim"
    use "lunarvim/onedarker.nvim"
    use {
        "lunarvim/darkplus.nvim",
        -- commit = "fe67a1a1663e65ac4fbd3e9a18874d6990a4f6e5"
    }
    -- use "tomasiser/vim-code-dark"
    -- use "Mofiqul/vscode.nvim"

    -- cmp plugins
    use "hrsh7th/nvim-cmp"    -- The completion plugin
    use "hrsh7th/cmp-buffer"  -- buffer completions
    use "hrsh7th/cmp-path"    -- path completions
    use "hrsh7th/cmp-cmdline" -- cmdline completions
    use "hrsh7th/cmp-nvim-lsp"
    use "hrsh7th/cmp-nvim-lua"
    use "saadparwaiz1/cmp_luasnip" -- snippet completions

    -- snippets
    use "L3MON4D3/LuaSnip"             --snippet engine
    use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

    -- LSP
    use "neovim/nvim-lspconfig"             -- enable LSP
    use "williamboman/mason.nvim"           -- simple to use language server installer
    use "williamboman/mason-lspconfig.nvim" -- simple to use language server installer
    use "jose-elias-alvarez/null-ls.nvim"   -- for formatters and linters
    use { "RRethy/vim-illuminate" }         -- automatically highlighting other uses of the word under the cursor using either LSP, Tree-sitter, or regex matching-

    -- Telescope
    use "nvim-telescope/telescope.nvim"
    -- use {"nvim-telescope/telescope.nvim", tag="nvim-0.6"}
    use "nvim-telescope/telescope-dap.nvim"

    -- Treesitter
    use {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
        -- commit = "bc25a6a5c4fd659bbf78ba0a2442ecf14eb00398"
    }
    use "JoosepAlviste/nvim-ts-context-commentstring"

    -- Git
    use "lewis6991/gitsigns.nvim"

    -- Tmux-vim integration
    use "aserowy/tmux.nvim"

    -- Debug Adapter Protocol
    use 'mfussenegger/nvim-dap'
    use 'mfussenegger/nvim-dap-python'
    use 'rcarriga/nvim-dap-ui'
    use 'theHamsta/nvim-dap-virtual-text'

    -- Annotation Toolkit
    use {
        "danymat/neogen",
        -- Uncomment next line if you want to follow only stable versions
        -- tag = "*"
    }

    ------------------------
    --- NON-LUA PLUGINS ---
    ------------------------

    -- Markdown preview in the browser
    use {
        'iamcco/markdown-preview.nvim',
        run = function() vim.fn['mkdp#util#install']() end,
        ft = { 'markdown' }
    }

    -- Debug Adapter Protocol
    use {
        'puremourning/vimspector',
        run = ":VimspectorUpdate",
        config = function()
            require("user.vimspector").setup()
        end,
    }

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)
