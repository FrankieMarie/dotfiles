-- Tabline-style buffer list at the top. Tab / S-Tab to cycle.
require("bufferline").setup({
  options = {
    offsets = {
      { filetype = "NvimTree", text = "Explorer", highlight = "Directory", separator = true },
    },
    separator_style = "thin",
    show_buffer_close_icons = false,
    show_close_icon = false,
  },
})

vim.keymap.set("n", "<Tab>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
vim.keymap.set("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Previous buffer" })
