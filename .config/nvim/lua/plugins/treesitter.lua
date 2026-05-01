-- Syntax highlighting via tree-sitter parsers.
require("nvim-treesitter").install({
  "lua", "vim", "vimdoc", "bash",
  "python",
  "javascript", "typescript", "tsx",
  "html", "css",
  "json", "yaml", "toml",
  "markdown", "markdown_inline",
  "astro",
  "dockerfile",
})

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("UserTreesitter", { clear = true }),
  callback = function()
    pcall(vim.treesitter.start)
  end,
})
