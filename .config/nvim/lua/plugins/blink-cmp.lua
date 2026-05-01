-- Autocompletion. Sources: lsp, path, snippets, buffer.
require("blink.cmp").setup({
  keymap = { preset = "default" },
  sources = {
    default = { "lsp", "path", "snippets", "buffer" },
  },
})
