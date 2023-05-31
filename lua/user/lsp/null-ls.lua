local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
	debug = false,
	sources = {
		formatting.stylua,
		formatting.prettier.with({ extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" } }),
		formatting.black.with({ extra_args = { "--fast", "-l 88" } }),
		diagnostics.flake8.with({ extra_args = { "--ignore=E501,W503" } }), -- ignoring "line too long" & "line break before binary operator"
		diagnostics.mypy.with({ extra_args = { "--strict" } }),
		-- diagnostics.cppcheck.with({extra_args = { "--language=cpp" }})
	},
})
