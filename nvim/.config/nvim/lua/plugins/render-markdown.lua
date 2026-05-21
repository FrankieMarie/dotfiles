require("render-markdown").setup({
  file_types = { "markdown", "mdx" },
  completions = { lsp = { enabled = true } },
})
