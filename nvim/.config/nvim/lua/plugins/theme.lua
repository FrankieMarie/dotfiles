vim.opt.background = "dark"
vim.opt.fillchars:append({ vert = " " })

require("catppuccin").setup({
  flavour = "frappe",
  transparent_background = true,
  styles = {
    comments = { "italic" },
    keywords = { "italic" },
    functions = { "italic" },
    strings = { "italic" },
    variables = { "italic" },
  },
  integrations = {
    blink_cmp = true,
    flash = true,
    render_markdown = true,
  },
})

vim.cmd.colorscheme("catppuccin")
