local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
    return
end

local setup = {
    plugins = {
        marks = true, -- shows a list of your marks on ' and `
        registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
        spelling = {
            enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
            suggestions = 20, -- how many suggestions should be shown in the list?
        },
        -- the presets plugin, adds help for a bunch of default keybindings in Neovim
        -- No actual key bindings are created
        presets = {
            operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
            motions = true, -- adds help for motions
            text_objects = true, -- help for text objects triggered after entering an operator
            windows = true, -- default bindings on <c-w>
            nav = true, -- misc bindings to work with windows
            z = true, -- bindings for folds, spelling and others prefixed with z
            g = true, -- bindings for prefixed with g
        },
    },
    -- add operators that will trigger motion and text object completion
    -- to enable all native operators, set the preset / operators plugin above
    -- operators = { gc = "Comments" },
    key_labels = {
        -- override the label used to display some keys. It doesn't effect WK in any other way.
        -- For example:
        -- ["<space>"] = "SPC",
        -- ["<cr>"] = "RET",
        -- ["<tab>"] = "TAB",
    },
    icons = {
        breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
        separator = "➜", -- symbol used between a key and it's label
        group = "+", -- symbol prepended to a group
    },
    popup_mappings = {
        scroll_down = "<c-d>", -- binding to scroll down inside the popup
        scroll_up = "<c-u>", -- binding to scroll up inside the popup
    },
    window = {
        border = "rounded", -- none, single, double, shadow
        position = "bottom", -- bottom, top
        margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
        padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
        winblend = 0,
    },
    layout = {
        height = { min = 4, max = 25 }, -- min and max height of the columns
        width = { min = 20, max = 50 }, -- min and max width of the columns
        spacing = 3, -- spacing between columns
        align = "left", -- align columns left, center or right
    },
    ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
    hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
    show_help = true, -- show help message on the command line when the popup is visible
    triggers = "auto", -- automatically setup triggers
    -- triggers = {"<leader>"} -- or specify a list manually
    triggers_blacklist = {
        -- list of mode / prefixes that should never be hooked by WhichKey
        -- this is mostly relevant for key maps that start with a native binding
        -- most people should not need to change this
        i = { "j", "k" },
        v = { "j", "k" },
    },
}

local opts = {
    mode = "n", -- NORMAL mode
    prefix = "<leader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = true, -- use `nowait` when creating keymaps
}

local mappings = {
    --   ["a"] = { "<cmd>Alpha<cr>", "Alpha" },
    --   ["b"] = {
    --     "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<cr>",
    --     "Buffers",
    --   },
    ["e"] = { "<cmd>NvimTreeToggle<cr>", "Explorer" },
    ["w"] = { "<cmd>w!<CR>", "Save" },
    ["q"] = { "<cmd>q!<CR>", "Quit" },
    ["c"] = { "<cmd>Bdelete!<CR>", "Close Buffer" },
    ["h"] = { "<cmd>nohlsearch<CR>", "No Highlight" },
    ["f"] = {
        "<cmd>lua require('telescope.builtin').find_files({hidden=true, require('telescope.themes').get_dropdown{previewer = false}})<cr>",
        "Find files",
    },
    ["F"] = { "<cmd>Telescope live_grep theme=ivy<cr>", "Find Text" },
    ["P"] = { "<cmd>lua require('telescope').extensions.projects.projects()<cr>", "Projects" },

    p = {
        name = "Packer",
        c = { "<cmd>PackerCompile<cr>", "Compile" },
        i = { "<cmd>PackerInstall<cr>", "Install" },
        s = { "<cmd>PackerSync<cr>", "Sync" },
        S = { "<cmd>PackerStatus<cr>", "Status" },
        u = { "<cmd>PackerUpdate<cr>", "Update" },
    },

    g = {
        name = "Git",
        g = { "<cmd>lua _LAZYGIT_TOGGLE()<CR>", "Lazygit" },
        j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
        k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
        l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
        p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
        r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
        R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
        s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
        u = {
            "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
            "Undo Stage Hunk",
        },
        o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
        b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
        c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
        d = {
            "<cmd>Gitsigns diffthis HEAD<cr>",
            "Diff",
        },
    },

    l = {
        name = "LSP",
        a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
        d = { "<cmd>lua vim.diagnostic.setloclist()<cr>", "Document Diagnostics" },
        w = {
            "<cmd>Telescope lsp_workspace_diagnostics<cr>",
            "Workspace Diagnostics",
        },
        f = { "<cmd>lua vim.lsp.buf.formatting()<cr>", "Format" },
        i = { "<cmd>LspInfo<cr>", "Info" },
        I = { "<cmd>LspInstallInfo<cr>", "Installer Info" },
        j = {
            "<cmd>lua vim.diagnostic.goto_next()<CR>",
            "Next Diagnostic",
        },
        k = {
            "<cmd>lua vim.diagnostic.goto_prev()<cr>",
            "Prev Diagnostic",
        },
        l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
        q = { "<cmd>lua vim.diagnostic.setqflist()<cr>", "Quickfix" },
        r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
        s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
        S = {
            "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
            "Workspace Symbols",
        },
    },
    s = {
        name = "Search",
        b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
        c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
        h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
        M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
        r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
        R = { "<cmd>Telescope registers<cr>", "Registers" },
        k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
        C = { "<cmd>Telescope commands<cr>", "Commands" },
    },

    -- t = {
    --     name = "Terminal",
    --     n = { "<cmd>lua _NODE_TOGGLE()<cr>", "Node" },
    --     u = { "<cmd>lua _NCDU_TOGGLE()<cr>", "NCDU" },
    --     t = { "<cmd>lua _HTOP_TOGGLE()<cr>", "Htop" },
    --     p = { "<cmd>lua _PYTHON_TOGGLE()<cr>", "Python" },
    --     f = { "<cmd>ToggleTerm direction=float<cr>", "Float" },
    --     h = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", "Horizontal" },
    --     v = { "<cmd>ToggleTerm size=80 direction=vertical<cr>", "Vertical" },
    -- },
    t = {
        name = "Termdebug",
        b = { "<cmd>Break<cr>", "Add Breakpoint" },
        B = { "<cmd>Clear<cr>", "Remove Breakpoint" },
        c = { "<cmd>Continue<cr>", "Continue" },
        d = { "<cmd>call TermDebugSendCommand('down')<cr>", "Go down in stack trace" },
        e = { "<cmd>Evaluate<cr>", "Evaluate expression under cursor" },
        f = { "<cmd>call TermDebugSendCommand('f '.input('Frame number: '))<cr>", "Go to frame no <input>" },
        i = { "<cmd>Step<cr>", "Step Into" },
        l = { "<cmd>call TermDebugSendCommand('info break')<cr>", "List Breakpoints" },
        n = { "<cmd>Over<cr>", "Step Over" },
        o = { "<cmd>Finish<cr>", "Step Out" },
        q = { "<cmd>Stop<cr>", "Quit" },
        r = { "<cmd>call TermDebugSendCommand('u '.line('.'))<cr>", "Run to Cursor" },
        R = { "<cmd>call TermDebugSendCommand('run')<cr><cmd>call TermDebugSendCommand('y')<cr>", "Run program" },
        s = { "<cmd>packadd termdebug<cr><cmd>Termdebug<cr>", "Start Termdebug" },
        t = { "<cmd>call TermDebugSendCommand('bt')<cr>", "Print stack trace" },
        u = { "<cmd>call TermDebugSendCommand('up')<cr>", "Go up in stack trace" },
        x = { "<cmd>Gdb<cr><cmd>call TermDebugSendCommand('quit')<cr><cmd>call TermDebugSendCommand('y')<cr><cmd>Bdelete!<cr>", "Terminate" },
    },

    d = {
        name = "Nvim Debug Adapter Protocoll",
        R = { "<cmd>lua require'dap'.run_to_cursor()<cr>", "Run to Cursor" },
        E = { "<cmd>lua require'dapui'.eval(vim.fn.input '[Expression] > ')<cr>", "Evaluate Input" },
        C = { "<cmd>lua require'dap'.set_breakpoint(vim.fn.input '[Condition] > ')<cr>", "Conditional Breakpoint" },
        U = { "<cmd>lua require'dapui'.toggle()<cr>", "Toggle UI" },
        b = { "<cmd>lua require'dap'.step_back()<cr>", "Step Back" },
        c = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
        d = { "<cmd>lua require'dap'.down()<cr>", "Go down in stack trace" },
        e = { "<cmd>lua require'dapui'.eval()<cr>", "Evaluate" },
        g = { "<cmd>lua require'dap'.session()<cr>", "Get Session" },
        h = { "<cmd>lua require'dap.ui.widgets'.hover()<cr>", "Hover Variables" },
        S = { "<cmd>lua require'dap.ui.widgets'.centered_float(require'dap.ui.widgets'.scopes)<cr>", "Scopes" },
        i = { "<cmd>lua require'dap'.step_into()<cr>", "Step Into" },
        o = { "<cmd>lua require'dap'.step_over()<cr>", "Step Over" },
        p = { "<cmd>lua require'dap'.pause.toggle()<cr>", "Pause" },
        q = { "<cmd>lua require'dap'.close()<cr>", "Quit" },
        -- r = { "<cmd>lua require'dap'.repl.toggle({},'vsplit')<cr>", "Toggle Repl" },
        r = { "<cmd>lua require'dap'.repl.toggle({height=10},hsplit)<cr>", "Toggle Repl" },
        s = { "<cmd>Telescope dap configurations<cr>", "Start / Configs" },
        -- s = { "<cmd>lua require'dap'.continue()<cr>", "Start" },
        t = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Toggle Breakpoint" },
        x = { "<cmd>lua require'dap'.terminate()<cr>", "Terminate" },
        u = { "<cmd>lua require'dap'.up()<cr>", "Go up in stack trace" },
        V = { "<cmd>Telescope dap variables<cr>", "Variables" },
        f = { "<cmd>Telescope dap frames<cr>", "Frames" },
        l = { "<cmd>Telescope dap list_breakpoints<cr>", "List Breakpoints" },
        ["?"] = { "<cmd>Telescope dap commands<cr>", "Commands" },
        ["<F5>"] = { "<cmd>lua require'dap'.continue()<CR>", "Continue" },
        ["<F10>"] = { "<cmd>lua require'dap'.step_over()<CR>", "Step over" },
        ["<F11>"] = { "<cmd>lua require'dap'.step_into()<CR>", "Step into" },
        ["<F12>"] = { "<cmd>lua require'dap'.step_out()<CR>", "Step out" },
    },

    v = {
        name = "Vimspector",
        I = { "<cmd>VimspectorInstall<cr>", "Install" },
        U = { "<cmd>VimspectorUpdate<cr>", "Update" },
        b = { "<plug>VimspectorBreakpoints<cr>", "Show Breakpoints" },
        e = { "<Plug>VimspectorBalloonEval<cr>", "Evaluate" },
        R = { "<cmd>call vimspector#RunToCursor()<cr>", "Run to Cursor" },
        c = { "<cmd>call vimspector#Continue()<cr>", "Continue" },
        i = { "<cmd>call vimspector#StepInto()<cr>", "Step Into" },
        n = { "<cmd>call vimspector#StepOver()<cr>", "Step Over" },
        s = { "<cmd>call vimspector#Launch()<cr>", "Start" },
        l = { "<cmd>lua require('user.vimspector').setup()<cr>", "Start" },
        t = { "<cmd>call vimspector#ToggleBreakpoint()<cr>", "Toggle Breakpoint" },
        o = { "<cmd>call vimspector#StepOut()<cr>", "Step Out" },
        u = { "<cmd>call vimspector#UpFrame()<cr>", "Go up in stack trace" },
        d = { "<cmd>call vimspector#DownFrame()<cr>", "Go down in stack trace" },
        S = { "<cmd>call vimspector#Stop()<cr>", "Stop" },
        r = { "<cmd>call vimspector#Restart()<cr>", "Restart" },
        x = { "<cmd>VimspectorReset<cr>", "Reset" },
        -- H = { "<cmd>lua require('user.vimspector').toggle_human_mode()<cr>", "Toggle HUMAN mode" },
    },

    n = {
        name = "Neogen docstring",
        c = { "<cmd>lua require('neogen').generate({ type = 'class' })<CR>", "Class"},
        f = { "<cmd>lua require('neogen').generate({ type = 'func' })<CR>", "Function"},
        F = { "<cmd>lua require('neogen').generate({ type = 'file' })<CR>", "File"},
        t = { "<cmd>lua require('neogen').generate({ type = 'type' })<CR>", "Type"},
    },
}

which_key.setup(setup)
which_key.register(mappings, opts)
