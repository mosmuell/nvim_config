--- @brief
---
--- https://github.com/PowerShell/PowerShellEditorServices
---
--- Language server for PowerShell.
---
--- To install, download and extract PowerShellEditorServices.zip
--- from the [releases](https://github.com/PowerShell/PowerShellEditorServices/releases).
--- To configure the language server, set the property `bundle_path` to the root
--- of the extracted PowerShellEditorServices.zip.
---
--- ```lua
--- vim.lsp.config('powershell_es', {
---   bundle_path = 'c:/w/PowerShellEditorServices',
--- })
--- ```
---
--- By default the language server is started in `pwsh` (PowerShell Core). This can be changed by specifying `shell`.
---
--- ```lua
--- vim.lsp.config('powershell_es', {
---   bundle_path = 'c:/w/PowerShellEditorServices',
---   shell = 'powershell.exe',
--- })
--- ```
---
--- Note that the execution policy needs to be set to `Unrestricted` for the languageserver run under PowerShell
---
--- If necessary, specific `cmd` can be defined instead of `bundle_path`.
--- See [PowerShellEditorServices](https://github.com/PowerShell/PowerShellEditorServices#standard-input-and-output)
--- to learn more.
---
--- ```lua
--- vim.lsp.config('powershell_es', {
---   cmd = {'pwsh', '-NoLogo', '-NoProfile', '-Command', "c:/PSES/Start-EditorServices.ps1 ..."},
--- })
--- ```
---

---@type vim.lsp.Config
return {
  bundle_path = vim.fn.expand("$MASON/packages/powershell-editor-services/"),
  shell = "pwsh",
  filetypes = { "ps1" },
  root_markers = { "PSScriptAnalyzerSettings.psd1", ".git" },
}
