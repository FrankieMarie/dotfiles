vim.pack.add({
  { src = "https://github.com/vague-theme/vague.nvim" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
  { src = "https://github.com/nvim-tree/nvim-web-devicons" },
  { src = "https://github.com/ibhagwan/fzf-lua" },
  { src = "https://github.com/lewis6991/gitsigns.nvim" },
  { src = "https://github.com/nvim-tree/nvim-tree.lua" },
  { src = "https://github.com/Saghen/blink.cmp",                version = vim.version.range("1.*") },
  { src = "https://github.com/stevearc/conform.nvim" },
  { src = "https://github.com/akinsho/bufferline.nvim" },
  { src = "https://github.com/echasnovski/mini.bufremove" },
  { src = "https://github.com/windwp/nvim-ts-autotag" },
  { src = "https://github.com/windwp/nvim-autopairs" },
  { src = "https://github.com/christoomey/vim-tmux-navigator" },
  { src = "https://github.com/MeanderingProgrammer/render-markdown.nvim" },
})

require("plugins.vague")
require("plugins.treesitter")
require("plugins.fzf")
require("plugins.gitsigns")
require("plugins.nvim-tree")
require("plugins.blink-cmp")
require("plugins.conform")
require("plugins.bufferline")
require("plugins.bufremove")
require("plugins.ts-autotag")
require("plugins.autopairs")
require("plugins.tmux-navigator")
require("plugins.render-markdown")
