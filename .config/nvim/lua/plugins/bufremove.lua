-- Close buffers without disturbing window layout. <leader>bd.
require("mini.bufremove").setup({})

vim.keymap.set("n", "<leader>bd", function()
  require("mini.bufremove").delete()
end, { desc = "Close buffer" })
