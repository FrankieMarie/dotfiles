-- Astro LSP. Single-file component support for .astro files.
return {
  cmd = { "astro-ls", "--stdio" },
  filetypes = { "astro" },
  root_markers = {
    "astro.config.js", "astro.config.mjs",
    "astro.config.ts", "astro.config.cjs",
  },
}
