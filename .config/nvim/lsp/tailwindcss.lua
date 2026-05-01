-- Tailwind CSS LSP. Class-name completion, hover with rendered styles.
return {
  cmd = { "tailwindcss-language-server", "--stdio" },
  filetypes = {
    "html", "css",
    "javascript", "javascriptreact",
    "typescript", "typescriptreact",
    "astro", "svelte", "vue",
  },
  root_markers = {
    "tailwind.config.js", "tailwind.config.ts",
    "tailwind.config.cjs", "tailwind.config.mjs",
    "postcss.config.js", "postcss.config.ts",
    "postcss.config.cjs", "postcss.config.mjs",
  },
  settings = {
    tailwindCSS = {
      validate = true,
      lint = {
        cssConflict = "warning",
        invalidApply = "error",
      },
    },
  },
}
