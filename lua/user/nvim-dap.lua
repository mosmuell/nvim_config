local status_ok, nvim_dap = pcall(require, "dap")
if not status_ok then
    return
end

local status_virtual_text, nvim_dap_virtual_text = pcall(require, "nvim-dap-virtual-text")
if status_virtual_text then
    nvim_dap_virtual_text.setup {
        -- enabled = true,                        -- enable this plugin (the default)
        -- enabled_commands = true,               -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
        -- highlight_changed_variables = true,    -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
        -- highlight_new_as_changed = false,      -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
        -- show_stop_reason = true,               -- show stop reason when stopped for exceptions
        commented = true,                     -- prefix virtual text with comment string
        -- only_first_definition = true,          -- only show virtual text at first definition (if there are multiple)
        all_references = true,                -- show virtual text on all all references of the variable (not only definitions)
        -- filter_references_pattern = '<module', -- filter references (not definitions) pattern when all_references is activated (Lua gmatch pattern, default filters out Python modules)
        -- -- experimental features:
        -- virt_text_pos = 'eol',                 -- position of virtual text, see `:h nvim_buf_set_extmark()`
        -- all_frames = false,                    -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
        -- virt_lines = false,                    -- show virtual lines instead of virtual text (will flicker!)
        -- virt_text_win_col = nil                -- position the virtual text at a fixed window column (starting from the first text column) ,
        --                                        -- e.g. 80 to position at column 80, see `:h nvim_buf_set_extmark()`
    }
end

local status_dap_ui, dap_ui = pcall(require, "dapui")
if status_dap_ui then
    dap_ui.setup {
        icons = { expanded = "▾", collapsed = "▸" },
        mappings = {
            -- Use a table to apply multiple mappings
            expand = { "<CR>", "<2-LeftMouse>" },
            open = "o",
            remove = "d",
            edit = "e",
            repl = "r",
            toggle = "t",
        },
        -- Expand lines larger than the window
        -- Requires >= 0.7
        expand_lines = vim.fn.has("nvim-0.7"),
        sidebar = {
            -- You can change the order of elements in the sidebar
            elements = {
                -- Provide as ID strings or tables with "id" and "size" keys
                {
                    id = "scopes",
                    size = 0.25, -- Can be float or integer > 1
                },
                { id = "breakpoints", size = 0.25 },
                { id = "stacks", size = 0.25 },
                { id = "watches", size = 00.25 },
            },
            size = 40,
            position = "right", -- Can be "left", "right", "top", "bottom"
        },
        tray = {
            elements = { "repl" },
            size = 10,
            position = "bottom", -- Can be "left", "right", "top", "bottom"
        },
        floating = {
            max_height = nil, -- These can be integers or a float between 0 and 1.
            max_width = nil, -- Floats will be treated as percentage of your screen.
            border = "single", -- Border style. Can be "single", "double" or "rounded"
            mappings = {
                close = { "q", "<Esc>" },
            },
        },
        windows = { indent = 1 },
        render = {
            max_type_length = nil, -- Can be integer or nil.
        }
    }

    -- use nvim-dap events to open and close the windows automatically
    nvim_dap.listeners.after.event_initialized["dapui_config"] = function()
        dap_ui.open()
    end
    nvim_dap.listeners.before.event_terminated["dapui_config"] = function()
        dap_ui.close()
    end
    nvim_dap.listeners.before.event_exited["dapui_config"] = function()
        dap_ui.close()
    end
end

-- nvim_dap.defaults.fallback.integratedTerminal = {
--     command = '/usr/bin/alacritty';
--     args = {'-e'};
-- }
--
-- nvim_dap.defaults.fallback.force_external_terminal = true


-- local repl = require 'dap.repl'
-- repl.commands = vim.tbl_extend('force', repl.commands, {
--     -- Add a new alias for the existing .exit command
--     exit = {'exit', '.exit', '.bye'},
--     -- Add your own commands; run `.echo hello world` to invoke
--     -- this function with the text "hello world"
--     custom_commands = {
--         ['.echo'] = function(text)
--             nvim_dap.repl.append(text)
--         end,
--         -- Hook up a new command to an existing dap function
--         ['.restart'] = nvim_dap.restart,
--     },
-- })

nvim_dap.adapters = {
    cppdbg = {
        id = 'cppdbg',
        type = 'executable',
        command = '~/.config/cpptools-linux/extension/debugAdapters/bin/OpenDebugAD7',
    },
    -- python = {
    --     type = 'executable',
    --     command = '~/.virtualenvs/debugpy/bin/python',
    --     args = { '-m', 'debugpy.adapter' },
    --     options = {
    --               source_filetype = 'python',
    --     }
    -- }
}

nvim_dap.configurations = {
    cpp = {
        {
            name = "Launch file",
            type = "cppdbg",
            request = "launch",
            MIMode = 'gdb',
            miDebuggerPath = '/usr/bin/gdb',
            program = function()
                return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
            end,
            cwd = '${workspaceFolder}',
            stopAtEntry = false,
            text = '-enable-pretty-printing',
            description =  'enable pretty printing',
            ignoreFailures = false
        },
        -- {
        --     name = 'Attach to gdbserver :1234',
        --     type = 'cppdbg',
        --     request = 'launch',
        --     MIMode = 'gdb',
        --     miDebuggerServerAddress = 'localhost:1234',
        --     miDebuggerPath = '/usr/bin/gdb',
        --     cwd = '${workspaceFolder}',
        --     program = function()
        --         return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        --     end,
        --     text = '-enable-pretty-printing',
        --     description =  'enable pretty printing',
        --     ignoreFailures = false
        -- },
    },
    python = {
        {
            type = "python",
            request = "launch",
            name = "Launch file",
            justMyCode = false,
            program = "${file}",
            console = "internalConsole", -- other options: internalTerminal, externalTerminal
            pythonPath = function()
                local venv_path = os.getenv('VIRTUAL_ENV')
                if venv_path then
                    return venv_path .. '/bin/python'
                end
                return vim.fn.exepath("python3") or vim.fn.exepath("python") or "python"
            end,

            -- function()
            --   -- Use activated virtualenv.
            --   if vim.env.VIRTUAL_ENV then
            --     return path.join(vim.env.VIRTUAL_ENV, "bin", "python")
            --   end
            --
            --   -- Find and use virtualenv in workspace directory.
            --   for _, pattern in ipairs({ "*", ".*" }) do
            --     local match = vim.fn.glob(path.join(workspace or vim.fn.getcwd(), pattern, "pyvenv.cfg"))
            --     if match ~= "" then
            --       return path.join(path.dirname(match), "bin", "python")
            --     end
            --   end
            --
            --   -- Fallback to system Python.
            --   return vim.fn.exepath("python3") or vim.fn.exepath("python") or "python"
            -- end
        },
        {
            type = "python",
            request = "attach",
            name = "Attach remote",
            justMyCode = false,
            host = function()
                local value = vim.fn.input("Host [127.0.0.1]: ")
                if value ~= "" then
                    return value
                end
                return "127.0.0.1"
            end,
            port = function()
                return tonumber(vim.fn.input("Port [5678]: ")) or 5678
            end,
        },
    },
}

-- nvim_dap.defaults.fallback.terminal_win_cmd = '20split new'
vim.fn.sign_define('DapBreakpoint', {text='🟥', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapBreakpointRejected', {text='🟦', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapStopped', {text='⭐️', texthl='', linehl='', numhl=''})
