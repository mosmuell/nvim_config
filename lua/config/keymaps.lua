local map = vim.keymap.set

map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })

-- Window navigation
map("n", "<M-h>", "<C-w>h", { desc = "Go to left window" })
map("n", "<M-j>", "<C-w>j", { desc = "Go to lower window" })
map("n", "<M-k>", "<C-w>k", { desc = "Go to upper window" })
map("n", "<M-l>", "<C-w>l", { desc = "Go to right window" })

-- Scroll and search centred
map("n", "<C-d>", "<C-d>zz", { desc = "Scroll down and centre" })
map("n", "<C-u>", "<C-u>zz", { desc = "Scroll up and centre" })
map("n", "n", "nzzzv", { desc = "Next search result (centred)" })
map("n", "N", "Nzzzv", { desc = "Previous search result (centred)" })

-- Stay in indent mode / move selected lines
map("v", "<", "<gv", { desc = "Indent left" })
map("v", ">", ">gv", { desc = "Indent right" })
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Diagnostics
map("n", "]d", function()
  vim.diagnostic.jump({ count = 1, float = true })
end, { desc = "Next diagnostic" })
map("n", "[d", function()
  vim.diagnostic.jump({ count = -1, float = true })
end, { desc = "Previous diagnostic" })
map("n", "<leader>lq", vim.diagnostic.setloclist, { desc = "Diagnostics to loclist" })
map("n", "<leader>lI", "<cmd>Mason<CR>", { desc = "Mason" })

-- Explorer
map("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" })

-- Telescope
local function telescope(picker)
  return function()
    require("telescope.builtin")[picker]()
  end
end
map("n", "<leader>ff", telescope("find_files"), { desc = "Find files" })
map("n", "<leader>fg", telescope("live_grep"), { desc = "Live grep" })
map("n", "<leader>fb", telescope("buffers"), { desc = "Find buffers" })
map("n", "<leader>fh", telescope("help_tags"), { desc = "Help tags" })
map("n", "<leader>fr", telescope("oldfiles"), { desc = "Recent files" })
map("n", "<leader>fd", telescope("diagnostics"), { desc = "Diagnostics" })
map("n", "<C-p>", function()
  require("plugins.telescope").project_files()
end, { desc = "Find project files" })

-- Terminal
map("n", "<leader>gg", function()
  require("plugins.toggleterm").lazygit_toggle()
end, { desc = "Lazygit" })

-- Comment (`gc`/`gcc` still work via Neovim's own built-in implementation;
-- these are the only paths that go through Comment.nvim's pre_hook, which
-- is what makes tsx comments context-aware).
-- <C-_> and <C-S-_> are how most terminals encode Ctrl+/ and Ctrl+Shift+/.
local function toggle_comment_line()
  require("Comment.api").toggle.linewise.current()
end
-- Must be a string, not a Lua callback: the literal <Esc> has to go through
-- normal input processing to finalize the '</'> marks and vim.fn.visualmode()
-- for the *current* selection before toggle.linewise() reads them. A Lua
-- function rhs runs before that happens and toggles the wrong/stale range.
local toggle_comment_visual = "<Esc><Cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>"
for _, keys in ipairs({ "<leader>/", "<C-_>", "<C-S-_>" }) do
  map("n", keys, toggle_comment_line, { desc = "Toggle comment" })
  map("x", keys, toggle_comment_visual, { desc = "Toggle comment" })
end

-- Illuminate: jump between other references of the symbol under the cursor
map("n", "<A-n>", function()
  require("illuminate").goto_next_reference()
end, { desc = "Next reference" })
map("n", "<A-p>", function()
  require("illuminate").goto_prev_reference()
end, { desc = "Previous reference" })
