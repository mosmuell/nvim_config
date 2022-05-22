local status_ok, dap_python = pcall(require, "dap-python")
if not status_ok then
    return
end

dap_python.setup('~/.virtualenvs/debugpy/bin/python', { include_configs = false })

-- Needed to setup python debug adapter
-- require('dap-python').setup('~/.virtualenvs/debugpy/bin/python')
