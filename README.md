# Personal Neovim Config

This repository contains my personal neovim configuration I use on a daily basis. It is based of the [nvim-basic-ide](https://github.com/LunarVim/nvim-basic-ide) and customised to my needs.

All the included plugins are pinned to a version that ensures they are compatible and will not update potentially introducing errors into your config.

## Install Neovim 0.9

You can install Neovim with your package manager e.g. brew, apt, dnf, pacman etc.. but remember that when you update your packages Neovim may be upgraded to a newer version.

If you would like to make sure Neovim only updates when you want it to than I recommend installing from source:

**NOTE** Verify the required [build prerequisites](https://github.com/neovim/neovim/wiki/Building-Neovim#build-prerequisites) for your system.

```sh
git clone https://github.com/neovim/neovim.git
cd neovim
git checkout release-0.9
make CMAKE_BUILD_TYPE=Release
sudo make install
```

## Installation

Clone this repository to the `~/.config/nvim` directory. Make sure to save or backup your old configuration beforehand.

```sh
git clone https://github.com/mosmuell/nvim_config.git ~/.config/nvim
```

Then, run `nvim` and wait for the plugins to be installed.

**NOTE** (You will notice treesitter pulling in a bunch of parsers the next time you open Neovim)

**NOTE** Checkout this file for some predefined keymaps: [keymaps](https://github.com/LunarVim/nvim-basic-ide/tree/master/lua/keymaps.lua)

## Get healthy

Open `nvim` and enter the following:

```
:checkhealth
```

You'll probably notice you don't have support for copy/paste also that python and node haven't been setup. Here's how to fix that:

### Copy/Paste

- On mac `pbcopy` should be builtin

- On Debian-base distros

  ```sh
  sudo apt install xsel # for X11
  sudo apt install wl-clipboard # for wayland
  ```

- On Fedora

  ```sh
  sudo dnf install xsel # for X11
  sudo dnf install wl-clipboard # for wayland
  ```

## Python / node support

Next we need to install python support (node is optional):

- Neovim `python` support

  ```sh
  sudo apt install python3-pynvim  # on Debian
  sudo dnf install python3-pynvim  # on Fedora
  ```

- Neovim `node` support

  ```sh
  npm i -g neovim
  ```

We will also need `ripgrep` for Telescope to work:

- Ripgrep

  ```sh
  sudo apt install ripgrep  # on Debian
  sudo dnf install ripgrep  # on Fedora
  ```

---

## Fonts

I recommend using the following repo to get a "Nerd Font" (Font that supports icons)

[getnf](https://github.com/ronniedroid/getnf)

## Configuration

### LSP

To add a new LSP

First Enter:

```
:Mason
```

and press `i` on the Language Server you wish to install

Next you will need to add the server to this list: [servers](./lua/utils/init.lua#L3)
Note: Builtin LSP doesn't contain all lsps from [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md).

If you want to install any from there, for example terraform_lsp(which adds more functionality than terraformls, like complete resource listing), you can either

1. add the lsp name in [mason lsp block](https://github.com/LunarVim/nvim-basic-ide/tree/master/user/utils/init.lua#L3-L13)

```lua
-- lua/utils/init.lua
M.servers = {
	"lua_ls",
	"cssls",
	"html",
	"tsserver",
	"pyright",
	"bashls",
	"jsonls",
	"yamlls",
}
```

2. or manually install the binary of the lsp and put it in your path by downloading the binary or through your package manager.

### Formatters and linters

Make sure the formatter or linter is installed and add it to this setup function: [null-ls](https://github.com/LunarVim/nvim-basic-ide/blob/e6b6c96280ca730a2564f2e36050df055acfb1a8/lua/user/null-ls.lua#L22)

**NOTE** Some are already setup as examples, remove them if you want

## Plugins

- [alpha-nvim](https://github.com/goolord/alpha-nvim)
- [bufdelete.nvim](https://github.com/famiu/bufdelete.nvim)
- [bufferline.nvim](https://github.com/akinsho/bufferline.nvim)
- [cmp-buffer](https://github.com/hrsh7th/cmp-buffer)
- [cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp)
- [cmp-nvim-lua](https://github.com/hrsh7th/cmp-nvim-lua)
- [cmp-path](https://github.com/hrsh7th/cmp-path)
- [cmp_luasnip](https://github.com/saadparwaiz1/cmp_luasnip)
- [Comment.nvim](https://github.com/numToStr/Comment.nvim)
- [darkplus.nvim](https://github.com/LunarVim/darkplus.nvim)
- [friendly-snippets](https://github.com/rafamadriz/friendly-snippets)
- [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)
- [indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim)
- [lazy.nvim](https://github.com/folke/lazy.nvim)
- [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)
- [LuaSnip](https://github.com/L3MON4D3/LuaSnip)
- [mason.nvim](https://github.com/williamboman/mason.nvim)
- [mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim)
- [mason-null-ls.nvim](https://github.com/jay-babu/mason-null-ls.nvim)
- [mason-nvim-dap.nvim](https://github.com/jay-babu/mason-nvim-dap.nvim)
- [null-ls.nvim](https://github.com/jose-elias-alvarez/null-ls.nvim)
- [nvim-autopairs](https://github.com/windwp/nvim-autopairs)
- [nvim-cmp](https://github.com/hrsh7th/nvim-cmp)
- [nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui)
- [nvim-dap](https://github.com/mfussenegger/nvim-dap)
- [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)
- [nvim-tree.lua](https://github.com/kyazdani42/nvim-tree.lua)
- [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
- [nvim-ts-context-commentstring](https://github.com/JoosepAlviste/nvim-ts-context-commentstring)
- [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons)
- [plenary.nvim](https://github.com/nvim-lua/plenary.nvim)
- [project.nvim](https://github.com/ahmedkhalf/project.nvim)
- [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)
- [toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim)
- [tokyonight.nvim](https://github.com/folke/tokyonight.nvim)
- [vim-illuminate](https://github.com/RRethy/vim-illuminate)
- [which-key.nvim](https://github.com/folke/which-key.nvim)
