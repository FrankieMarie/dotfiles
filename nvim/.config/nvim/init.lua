vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Disable netrw (replaced by nvim-tree)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("config.options")
require("config.keymaps")
require("config.autocmds")
require("config.plugins")
require("config.lsp")
