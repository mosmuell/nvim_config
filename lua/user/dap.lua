local M = {
  "mfussenegger/nvim-dap",
  commit = "6b12294a57001d994022df8acbe2ef7327d30587",
  event = "VeryLazy",
}

function M.config()
  local dap = require "dap"

  local dap_ui_status_ok, dapui = pcall(require, "dapui")
  if not dap_ui_status_ok then
    return
  end

  dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
  end

  dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
  end

  dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
  end

  dap.adapters = {
    python = {
      type = "executable",
      command = vim.fn.stdpath "data" .. "/mason/packages/debugpy/venv/bin/python",
      args = { "-m", "debugpy.adapter" },
      options = {
        source_filetype = "python",
      },
    },
    -- cppdbg = {
    --   id = "cppdbg",
    --   type = "executable",
    --   command = os.getenv "HOME" .. "/.config/cpptools-linux/extension/debugAdapters/bin/OpenDebugAD7",
    -- },
    lldb = {
      type = "executable",
      command = vim.fn.stdpath("data") .. "/mason/packages/codelldb/codelldb",
      name = "lldb",
    },
    codelldb = {
      type = "server",
      port = "${port}",
      executable = {
        -- provide the absolute path for `codelldb` command if not using the one installed using `mason.nvim`
        -- command = vim.fn.stdpath("data") .. "/mason/packages/codelldb/codelldb",
        args = { "--port", "${port}" },
        -- On windows you may have to uncomment this:
        -- detached = false,
      },
    },
  }
  dap.configurations = {
    python = {

      {
        type = "python",
        request = "launch",
        name = "Launch file",
        justMyCode = false,
        program = "${file}",
        console = "internalConsole", -- other options: internalTerminal, externalTerminal
        pythonPath = function()
          local venv_path = os.getenv "VIRTUAL_ENV"
          if venv_path then
            return venv_path .. "/bin/python"
          end
          return vim.fn.exepath "python3" or vim.fn.exepath "python" or "python"
        end,
      },
      {
        type = "python",
        request = "attach",
        name = "Attach remote",
        justMyCode = false,
        host = function()
          local value = vim.fn.input "Host [127.0.0.1]: "
          if value ~= "" then
            return value
          end
          return "127.0.0.1"
        end,
        port = function()
          return tonumber(vim.fn.input "Port [5678]: ") or 5678
        end,
      },
    },
    cpp = {
      {
        name = "Launch file",
        type = "lldb",
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
        type = "lldb",
        request = "launch",
        program = function()
          local path
          vim.ui.input({ prompt = "Path to executable: ", default = vim.loop.cwd() .. "/build/" }, function(input)
            path = input
          end)
          vim.cmd [[redraw]]
          return path
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
      },
    },
  }
end

return M
