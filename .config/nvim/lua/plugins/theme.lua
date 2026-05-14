vim.opt.background = "dark"

vim.g.zenwritten_transparent_background = true
vim.g.zenbones_transparent_background = true

vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = { "zenwritten", "zenbones" },
  callback = function()
    local pink = require(vim.g.colors_name .. ".palette").dark.blossom.hex
    for _, g in ipairs({
      "Operator", "String", "Character",
      "@operator", "@punctuation.bracket", "@punctuation.delimiter",
      "@tag.delimiter", "@string", "@string.escape",
      "@string.special", "@string.regex", "@character",
    }) do
      vim.api.nvim_set_hl(0, g, { fg = pink })
    end
  end,
})

vim.cmd.colorscheme("zenwritten")
