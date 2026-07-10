# nvim config

A Neovim configuration built from scratch on top of [`vim.pack`](https://neovim.io/doc/user/pack.html#vim.pack),
Neovim's built-in Git-based plugin manager (Neovim 0.12+). No plugin manager
plugin (lazy.nvim, packer, etc.) is used.

## Requirements

- Neovim **0.12+** (`vim.pack` is built in, no install step needed)
- `git`
- A C compiler (for treesitter parsers) and `tree-sitter-cli`
- [`ripgrep`](https://github.com/BurntSushi/ripgrep) for Telescope's live grep
- A [Nerd Font](https://www.nerdfonts.com/) for icons
- [`lazygit`](https://github.com/jesseduffield/lazygit) for `<leader>gg`
- On Linux only: `tmux`, for seamless pane navigation (see `tmux.nvim` below)

## Structure

```
init.lua                   entry point, loads everything in order
lua/config/options.lua     vim.opt / leader keys
lua/config/lsp.lua         LSP capabilities, diagnostics, vim.lsp.enable()
lua/config/keymaps.lua     general + telescope/explorer keymaps
lua/config/autocmds.lua    autocommands, incl. per-buffer LSP keymaps
lua/plugins/init.lua       vim.pack.add() spec list + per-plugin setup calls
lua/plugins/*.lua          one file per plugin, its setup() call
lsp/*.lua                  one file per LSP server (native vim.lsp.config)
```

## Plugins

Installed and loaded (in this order — see `lua/plugins/init.lua`) via
`vim.pack.add()`:

| Plugin | Purpose |
| --- | --- |
| `darkplus.nvim` | colorscheme, loaded before every other plugin |
| `plenary.nvim` | Lua stdlib used by Telescope |
| `nvim-web-devicons` | file icons used by Telescope / nvim-tree |
| `nvim-treesitter` | parsing: highlighting, indent, folding |
| `mason.nvim` | installs LSP servers / tools (`:Mason`) |
| `fidget.nvim` | LSP progress notifications |
| `luvit-meta` | `vim.uv` type stubs for `lazydev.nvim` |
| `lazydev.nvim` | fast, correct `lua_ls` setup for this config itself |
| `LuaSnip` + `cmp_luasnip` | snippet engine used by completion |
| `cmp-nvim-lsp`, `cmp-buffer`, `cmp-path` | completion sources |
| `nvim-cmp` | completion engine |
| `gitsigns.nvim` | git signs in the gutter, hunk actions |
| `nvim-ts-context-commentstring` | tsx-aware commentstring for Comment.nvim |
| `Comment.nvim` | `<leader>/` to toggle comments |
| `vim-illuminate` | highlight other references of the symbol under the cursor |
| `lualine.nvim` | statusline |
| `indent-blankline.nvim` | indent guides |
| `nvim-tree.lua` | file explorer |
| `telescope.nvim` | fuzzy finder |
| `toggleterm.nvim` | floating terminal, Lazygit toggle |
| `tmux.nvim` | Linux only: `<M-hjkl>`/`<M-arrows>` cross into tmux panes |
| `which-key.nvim` | keymap popup/discovery |

Plugins are plain Git checkouts under
`~/.local/share/nvim/site/pack/core/opt/`. The first launch creates
`nvim-pack-lock.json` in this config directory (`'packlockfile'`), pinning
the exact revision of every plugin; commit it so other machines install
identical versions. Useful commands: `:packupdate`, `:packdel`, `:help
vim.pack`.

## LSP servers

Native `vim.lsp.config`/`vim.lsp.enable` (no `nvim-lspconfig` plugin needed).
Every file in `lsp/` defines one server and is enabled automatically at
startup (see `lua/config/lsp.lua`). To add a server:

1. Install its binary via `:Mason`.
2. Add `lsp/<name>.lua` returning a `vim.lsp.Config` table (see
   `lsp/lua_ls.lua` / `lsp/jsonls.lua` for examples).
3. Restart Neovim.

## Key mappings

Leader is `<Space>`. Press `<Space>` and wait to see the which-key popup.

| Keys | Action |
| --- | --- |
| `<M-h>` / `j` / `k` / `l` | Go to window (Linux: crosses into tmux panes) |
| `<M-Up>` / `Down` / `Left` / `Right` | Linux only: resize the tmux pane |
| `<leader>e` | Toggle file explorer |
| `<leader>ff` / `fg` / `fb` / `fh` / `fr` / `fd` | Telescope: files / grep / buffers / help / recent / diagnostics |
| `<C-p>` | Telescope: project files (git files, falling back to find_files) |
| `<leader>gs` / `gr` / `gS` / `gu` / `gp` / `gb` / `gd` | Git: stage / reset / stage buffer / undo stage / preview / blame / diff hunk |
| `]h` / `[h` | Next / previous git hunk |
| `gc` / `gcc`, `<leader>/` / `<C-_>` / `<C-S-_>` | Toggle comment (operator / line, native and Comment.nvim) |
| `gd` / `gD` / `gI` / `gr` | Goto definition / declaration / implementation / references |
| `<A-n>` / `<A-p>` | Next / previous reference of symbol under cursor |
| `gl` | Open diagnostics float |
| `<leader>lr` / `la` / `lf` / `lh` | Rename / code action / format / toggle inlay hints |
| `<F2>` | Rename (alt) |
| `]d` / `[d`, `<leader>lj` / `lk` | Next / previous diagnostic |
| `<leader>lq` | Diagnostics to location list |
| `<leader>lI` | Open Mason |
| `<C-\>` | Toggle floating terminal |
| `<leader>gg` | Toggle Lazygit |

Neovim 0.11+'s [default LSP mappings](https://neovim.io/doc/user/lsp.html#lsp-defaults)
(`grn`, `gra`, `grr`, `gri`, `gO`, `K`, ...) are also active.
