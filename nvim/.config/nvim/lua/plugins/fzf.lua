-- Fuzzy finder for files, grep, buffers. Requires fzf binary on PATH.
require("fzf-lua").setup({})

local map = vim.keymap.set
map("n", "<leader>ff", "<cmd>FzfLua files<cr>", { desc = "Find files" })
map("n", "<leader>fg", "<cmd>FzfLua live_grep<cr>", { desc = "Live grep" })
map("n", "<leader>fb", "<cmd>FzfLua buffers<cr>", { desc = "Buffers" })
map("n", "<leader>fh", "<cmd>FzfLua helptags<cr>", { desc = "Help tags" })
map("n", "<leader>fr", "<cmd>FzfLua resume<cr>", { desc = "Resume last search" })
map("n", "<leader>gs", "<cmd>FzfLua git_status<cr>", { desc = "Git changed files" })
