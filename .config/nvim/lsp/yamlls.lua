-- YAML LSP. Auto-applies schemas (docker-compose, k8s, GH Actions, etc.).
return {
  cmd = { "yaml-language-server", "--stdio" },
  filetypes = { "yaml", "yaml.docker-compose", "yaml.gitlab" },
  root_markers = {
    "docker-compose.yml", "docker-compose.yaml",
    "compose.yml", "compose.yaml",
    ".github",
  },
  settings = {
    yaml = {
      schemaStore = {
        enable = true,
        url = "https://www.schemastore.org/api/json/catalog.json",
      },
      schemas = {
        ["https://json.schemastore.org/github-workflow.json"] = ".github/workflows/*.{yml,yaml}",
        ["https://json.schemastore.org/github-action.json"] = ".github/action.{yml,yaml}",
      },
      validate = true,
      completion = true,
      hover = true,
    },
  },
}
