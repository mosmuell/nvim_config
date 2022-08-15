local util = require("lspconfig/util")
local python_root_files = {
    'WORKSPACE', -- added for Bazel; items below are from default config
    'pyproject.toml',
    'setup.py',
    'setup.cfg',
    'requirements.txt',
    'Pipfile',
    'pyrightconfig.json',
}

local opts = {
    setup = {
        root_dir = util.root_pattern(unpack(python_root_files)),
        settings = {
            pyright = {
                autoSearchPaths = true,
                diagnosticMode = "workspace",
                useLibraryCodeForTypes = true
            },
        },
        single_file_support = true
    },
}

return opts
