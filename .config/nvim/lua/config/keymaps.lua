-- Leader is set in init.lua before this file is loaded.

-- Window navigation handled by vim-tmux-navigator (crosses into tmux panes too).

-- Clear search highlight
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<cr>")

-- Quick escape from insert mode
vim.keymap.set("i", "jk", "<Esc>")

-- Keep visual selection after indent
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Join line without moving cursor
vim.keymap.set("n", "J", "mzJ`z")

-- Keep cursor centered during search and half-page scroll
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Move selected lines in visual mode
vim.keymap.set("v", "J", ":m '>+1<cr>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<cr>gv=gv")

-- Show diagnostic error on current line
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Show diagnostic" })

-- LSP keymaps (only active when an LSP server attaches)
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local map = function(keys, func)
      vim.keymap.set("n", keys, func, { buffer = args.buf })
    end
    map("gd", vim.lsp.buf.definition)
    map("gr", vim.lsp.buf.references)
    map("K", vim.lsp.buf.hover)
    map("<leader>ca", vim.lsp.buf.code_action)
    map("<leader>rn", vim.lsp.buf.rename)
  end,
})
