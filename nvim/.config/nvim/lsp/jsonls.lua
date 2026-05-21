-- JSON LSP. Schema validation and hover docs. Formatting handled by prettier via conform.
return {
  cmd = { "vscode-json-language-server", "--stdio" },
  filetypes = { "json", "jsonc" },
  root_markers = { ".git" },
  init_options = {
    provideFormatter = false,
  },
  settings = {
    json = {
      validate = { enable = true },
    },
  },
}
