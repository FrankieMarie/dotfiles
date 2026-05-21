-- Bash/shell LSP. Surfaces shellcheck diagnostics automatically if shellcheck is on $PATH.
return {
  cmd = { "bash-language-server", "start" },
  filetypes = { "sh", "bash" },
  root_markers = { ".git" },
}
