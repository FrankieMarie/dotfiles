vim.opt.background = "dark"
vim.opt.fillchars:append({ vert = " " })

vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "habamax",
  callback = function()
    local groups = {
      "Normal", "NormalNC", "SignColumn", "Folded",
      "NvimTreeNormal", "NvimTreeNormalNC", "NvimTreeEndOfBuffer", "NvimTreeWinSeparator",
      "WinSeparator", "VertSplit",
      "TabLine", "TabLineFill", "TabLineSel",
    }
    for _, g in ipairs(groups) do
      vim.api.nvim_set_hl(0, g, { bg = "NONE" })
    end
  end,
})

vim.cmd.colorscheme("habamax")
