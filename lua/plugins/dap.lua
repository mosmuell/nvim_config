local M = {
  "mfussenegger/nvim-dap",
  commit = "6f79b822997f2e8a789c6034e147d42bc6706770",
  event = "VeryLazy",
}

M.daps = {
  "python",
  -- "codelldb",
}

function M.config()
  local dap = require("dap")

  -- turn of automatic launch.json loading
  ---@diagnostic disable-next-line: duplicate-set-field
  dap.providers.configs["dap.launch.json"] = function()
    return {}
  end

  -- https://github.com/mfussenegger/nvim-dap/wiki/Cookbook#map-k-to-hover-while-session-is-active
  local keymap_restore = {}
  dap.listeners.after["event_initialized"]["me"] = function()
    for _, buf in pairs(vim.api.nvim_list_bufs()) do
      local keymaps = vim.api.nvim_buf_get_keymap(buf, "n")
      for _, keymap in pairs(keymaps) do
        if keymap.lhs == "<C-k>" then
          table.insert(keymap_restore, keymap)
          vim.api.nvim_buf_del_keymap(buf, "n", "<C-k>")
        end
      end
    end
    vim.api.nvim_set_keymap("n", "<C-k>", "<cmd>lua require('dapui').eval()<cr>", { silent = true })
  end

  dap.listeners.after["event_terminated"]["me"] = function()
    for _, keymap in pairs(keymap_restore) do
      vim.api.nvim_buf_set_keymap(keymap.buffer, keymap.mode, keymap.lhs, keymap.rhs, { silent = keymap.silent == 1 })
    end
    keymap_restore = {}
  end

  dap.adapters = {
    python = {
      type = "executable",
      command = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python",
      args = { "-m", "debugpy.adapter" },
      options = {
        source_filetype = "python",
      },
    },
    codelldb = {
      type = "server",
      port = "${port}",
      executable = {
        -- provide the absolute path for `codelldb` command if not using the one installed using `mason.nvim`
        command = vim.fn.stdpath("data") .. "/mason/packages/codelldb/codelldb",
        args = { "--port", "${port}" },
        -- On windows you may have to uncomment this:
        -- detached = false,
      },
    },
    firefox = {
      type = "executable",
      command = "node",
      args = { vim.fn.stdpath("data") .. "/mason/packages/firefox-debug-adapter/dist/adapter.bundle.js" },
    },
  }
  dap.configurations = {
    python = {
      {
        name = "Python: Run Current File as Module",
        type = "python",
        request = "launch",
        module = "${fileAsModule}", -- self-defined variable. See get_launchjs_entries()
        console = "internalConsole",
        cwd = "${workspaceFolder}",
        justMyCode = false,
      },
      {
        type = "python",
        request = "launch",
        name = "Python: Launch Current File as Program",
        justMyCode = false,
        program = "${file}",
        console = "internalConsole", -- other options: internalTerminal, externalTerminal
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
    typescriptreact = {
      {
        name = "Debug with Firefox (port 5173)",
        type = "firefox",
        request = "launch",
        reAttach = true,
        url = "http://localhost:5173",
        webRoot = function()
          return vim.fn.input("Path to web root: ", vim.fn.getcwd() .. "/frontend", "dir")
        end,
        firefoxExecutable = "/usr/bin/firefox",
        profileDir = os.getenv("HOME") .. "/.mozilla/firefox/debug_profile", -- Firefox debug profile (you have to create this yourself in about:profiles)
        keepProfileChanges = true, -- Keep changes like "devtools.debugger.features.overlay = False"
      },
    },
    cpp = {
      {
        name = "Launch file",
        type = "codelldb",
        request = "launch",
        MIMode = "gdb",
        miDebuggerPath = "/usr/bin/gdb",
        program = function()
          return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopAtEntry = false,
        text = "-enable-pretty-printing",
        description = "enable pretty printing",
        ignoreFailures = false,
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
    c = {
      {
        name = "Launch file",
        type = "codelldb",
        request = "launch",
        program = function()
          local path
          vim.ui.input({ prompt = "Path to executable: ", default = vim.uv.cwd() .. "/build/" }, function(input)
            path = input
          end)
          vim.cmd([[redraw]])
          return path
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
      },
    },
  }

  local dap_ui_status_ok, dapui = pcall(require, "dapui")
  if not dap_ui_status_ok then
    return
  end

  dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
  end

  -- dap.listeners.before.event_terminated["dapui_config"] = function()
  --   dapui.close()
  -- end

  -- dap.listeners.before.event_exited["dapui_config"] = function()
  --   dapui.close()
  -- end
end

--- Derive the full module path based on the file's location
---@param full_file_path string The full path to the python file
---@param workspace_folder string The root directory of the project
---@return string module_path The module path in the format package1.subpackage1.module1
M.derive_module_path = function(full_file_path, workspace_folder)
  local module_path = full_file_path:sub(#workspace_folder + 2, -4) -- +2 to remove the trailing slash and the file extension

  -- Convert slashes to dots
  module_path = module_path:gsub("/", ".")

  return module_path
end

local get_launchjs_entries = function()
  -- get the entries of .vscode/launch.json
  require("dap.ext.vscode").load_launchjs(nil, {})
  -- update the pythonPath for each configuration to be the currently selected virtual environment
  for _, config in ipairs(require("dap").configurations.python) do
    config.pythonPath = require("utils.paths").venv_python()
    if config.module == "${fileAsModule}" or config["_module"] == "${fileAsModule}" then
      -- Need to store `fileAsModule` somewhere in the config to make sure this can be
      -- re-evaluated.
      config["_module"] = "${fileAsModule}"
      -- Retrieve the directory in which Neovim was started
      local workspace_folder = vim.fn.getcwd()
      -- Full path to the current file
      local current_file = vim.fn.expand("%:p")

      config.module = M.derive_module_path(current_file, workspace_folder)
    end
  end
end

M.launch_or_continue = function()
  get_launchjs_entries()
  require("dap").continue()
end

return M
