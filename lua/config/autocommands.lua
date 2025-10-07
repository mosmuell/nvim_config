-- Close certain pages (like help or man pages) by pressing 'q'
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "qf", "help", "man", "lspinfo", "spectre_panel" },
  callback = function()
    vim.cmd([[
      nnoremap <silent> <buffer> q :close<CR>
      set nobuflisted
    ]])
  end,
})

-- display lines as one long line when in gitcommit or markdown
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
  end,
})

-- Automatically close tab/vim when nvim-tree is the last window in the tab
-- vim.cmd("autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif")

-- make all windows the same height & width on each tab on VimResized
vim.api.nvim_create_autocmd({ "VimResized" }, {
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
})

-- Highlight yanked selection for 200 ms
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  callback = function()
    vim.hl.on_yank({ higroup = "Visual", timeout = 200 })
  end,
})

-- Setting shiftwidth based on file types
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "cpp", "c", "javascript", "javascriptreact", "typescript", "typescriptreact", "lua", "markdown" },
  callback = function()
    vim.cmd("setlocal shiftwidth=2")
  end,
})
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "python" },
  callback = function()
    vim.cmd("setlocal shiftwidth=4")
  end,
})

-- Unfold everything
-- vim.api.nvim_create_autocmd({ "BufEnter" }, {
--   pattern = { "*" },
--   callback = function()
--     vim.cmd("normal zR")
--   end,
-- })

vim.api.nvim_create_autocmd("LspAttach", {
  desc = "LSP actions",
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
    if not client then
      return
    end


    ---[[ Code Actions and Formatting on Save
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = vim.api.nvim_create_augroup("CodeAction and Format on Save", { clear = false }),
      buffer = args.buf,
      callback = function()
        -- if vim.bo.ft == "python" then
        --   vim.lsp.buf.code_action { context = { only = { "source.fixAll" }, diagnostics = {} }, apply = true }
        -- end

        if client:supports_method("textDocument/codeAction") then
          local function apply_code_action(action_type)
            local ctx = { only = action_type, diagnostics = {} }
            local actions = vim.lsp.buf.code_action({ context = ctx, apply = true, return_actions = true })

            -- only apply if code action is available
            if actions ~= nil and #actions > 0 then
              vim.lsp.buf.code_action({ context = ctx, apply = true })
            end
          end
          apply_code_action({ "source.fixAll" })
          -- apply_code_action({ "source.organizeImports" })
        end

        if not client:supports_method('textDocument/willSaveWaitUntil')
            and client:supports_method('textDocument/formatting') then
          vim.lsp.buf.format()
        end
      end,
    })
    ---]]

    ---[[ Disable default formatting
    if client.name == "tsserver" then
      client.server_capabilities.documentFormattingProvider = false
    end
    ---]]

    -- enable inlay hints (not sure if this is good here)
    if vim.lsp.inlay_hint then
      vim.lsp.inlay_hint.enable(true, { 0 })
    end

    if client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
    end

    if client:supports_method("textDocument/codeLens") then
      vim.api.nvim_create_autocmd({ "TextChanged", "InsertLeave" }, {
        buffer = args.buf,
        callback = function()
          vim.lsp.codelens.refresh({ bufnr = args.buf })
        end,
      })
    end

    ---[[ Lsp Keymaps
    local nmap = function(keys, func, desc)
      if desc then
        desc = "LSP: " .. desc
      end
      vim.keymap.set("n", keys, func, { buffer = args.buf, noremap = true, silent = true, desc = desc })
    end

    nmap("K", function() vim.lsp.buf.hover { border = "rounded", max_height = 25, max_width = 120 } end, "Open hover")
    nmap("gD", vim.lsp.buf.declaration, "Goto declaration")
    nmap("gd", vim.lsp.buf.definition, "Goto definition")
    nmap("gI", vim.lsp.buf.implementation, "List implementations")
    nmap("gr", vim.lsp.buf.references, "List references")
    nmap("<leader>la", vim.lsp.buf.code_action, "Code action")
    nmap("<leader>lj", function()
      vim.diagnostic.jump({ count = 1, float = true })
    end, "Move to next diagnostic")
    nmap("<leader>lk", function()
      vim.diagnostic.jump({ count = -1, float = true })
    end, "Move to previous diagnostic")
    nmap("<leader>lr", vim.lsp.buf.rename, "Rename")
    nmap("<F2>", vim.lsp.buf.rename, "Rename")

    -- Diagnostic
    vim.keymap.set("i", "<M-t>", function()
      vim.lsp.buf.signature_help { border = "rounded", max_height = 25, max_width = 120 }
    end, { buffer = args.buf })
    nmap("<leader>lq", vim.diagnostic.setloclist, "Open diagnostics list")
    nmap("gl", vim.diagnostic.open_float, "Open diagnostics float")

    -- toogle inlay hints
    nmap("<leader>lh", function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
    end, "Toggle inlay hints")
    ---]]
  end,
})
