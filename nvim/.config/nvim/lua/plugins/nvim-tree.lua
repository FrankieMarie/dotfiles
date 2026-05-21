-- File explorer sidebar. <leader>e to toggle.
require("nvim-tree").setup({
  view = {
    width = {
      min = 20,
      max = 50,
    },
  },
})

vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", { desc = "Toggle file tree" })
