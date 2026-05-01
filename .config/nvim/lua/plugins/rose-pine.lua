-- Colorscheme. Variants: main (dark), moon (softer dark), dawn (light).
require("rose-pine").setup({
  variant = "main", -- "main" | "moon" | "dawn"
  styles = { transparency = true },
})
vim.cmd.colorscheme("rose-pine")
