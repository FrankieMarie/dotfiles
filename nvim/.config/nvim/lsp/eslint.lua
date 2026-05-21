-- JS/TS lint LSP. Reads project's .eslintrc.* or eslint.config.*.
return {
  cmd = { "vscode-eslint-language-server", "--stdio" },
  filetypes = {
    "javascript", "javascriptreact", "javascript.jsx",
    "typescript", "typescriptreact", "typescript.tsx",
  },
  root_markers = {
    ".eslintrc", ".eslintrc.json", ".eslintrc.js", ".eslintrc.cjs",
    "eslint.config.js", "eslint.config.mjs", "eslint.config.cjs",
  },
  settings = {
    workingDirectory = { mode = "location" },
    validate = "on",
    format = false,
  },
  -- Force push diagnostics; pull diagnostics crashes with "path undefined"
  on_init = function(client)
    client.server_capabilities.diagnosticProvider = nil
  end,
}
