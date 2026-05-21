vim.opt.background = "dark"

vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "yorumi",
  callback = function()
    for _, g in ipairs({ "Normal", "NormalNC", "SignColumn", "Folded", "NvimTreeNormal" }) do
      vim.api.nvim_set_hl(0, g, { bg = "NONE" })
    end
  end,
})

vim.cmd.colorscheme("yorumi")
