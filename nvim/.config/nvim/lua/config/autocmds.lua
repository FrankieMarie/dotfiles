local augroup = vim.api.nvim_create_augroup("UserAutocmds", { clear = true })

-- highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup,
  callback = function()
    vim.hl.on_yank({
      higroup = "Search",
      timeout = 200,
    })
  end,
})

-- auto-reload files changed outside nvim
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold" }, {
  group = augroup,
  command = "checktime",
})

-- absolute line numbers in insert mode, relative everywhere else
vim.api.nvim_create_autocmd("InsertEnter", {
  group = augroup,
  callback = function() vim.wo.relativenumber = false end,
})
vim.api.nvim_create_autocmd("InsertLeave", {
  group = augroup,
  callback = function() vim.wo.relativenumber = true end,
})

-- filetype mappings
vim.filetype.add({
  extension = {
    mdx = "mdx",
    astro = "astro",
  },
})

-- wrap, linebreak and spellcheck on markdown and text files
vim.api.nvim_create_autocmd("FileType", {
  group = augroup,
  pattern = { "markdown", "mdx", "text", "gitcommit" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
    vim.opt_local.spell = true
  end,
})
