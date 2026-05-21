-- Inherit blink.cmp completion capabilities for all servers
vim.lsp.config("*", {
  capabilities = require("blink.cmp").get_lsp_capabilities(),
})

vim.lsp.enable({
  "lua_ls",
  "vtsls", "eslint",
  "basedpyright", "ruff",
  "tailwindcss", "astro",
  "yamlls", "dockerls",
})

-- Diagnostic display
vim.diagnostic.config({
  virtual_text = { spacing = 4, prefix = "●" },
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = { border = "rounded", source = true },
})
