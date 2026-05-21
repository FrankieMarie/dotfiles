-- Dockerfile LSP. Hover for instructions, lint, completion.
return {
  cmd = { "docker-langserver", "--stdio" },
  filetypes = { "dockerfile" },
  root_markers = { "Dockerfile", ".git" },
}
