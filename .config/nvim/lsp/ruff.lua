-- Python lint and format LSP. Hover disabled so basedpyright owns it.
return {
  cmd = { "ruff", "server" },
  filetypes = { "python" },
  root_markers = { "pyproject.toml", "ruff.toml", ".ruff.toml", ".git" },
  -- disable hover so basedpyright owns it
  on_attach = function(client)
    client.server_capabilities.hoverProvider = false
  end,
}
