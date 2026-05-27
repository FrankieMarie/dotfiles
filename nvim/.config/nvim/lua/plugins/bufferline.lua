-- Tabline-style buffer list at the top. Tab / S-Tab to cycle.
local hl_keys = {
  "trunc_marker", "fill", "group_separator", "group_label",
  "tab", "tab_selected", "tab_close",
  "close_button", "close_button_visible", "close_button_selected",
  "background", "buffer", "buffer_visible", "buffer_selected",
  "numbers", "numbers_selected", "numbers_visible",
  "diagnostic", "diagnostic_visible", "diagnostic_selected",
  "hint", "hint_visible", "hint_selected",
  "hint_diagnostic", "hint_diagnostic_visible", "hint_diagnostic_selected",
  "info", "info_visible", "info_selected",
  "info_diagnostic", "info_diagnostic_visible", "info_diagnostic_selected",
  "warning", "warning_visible", "warning_selected",
  "warning_diagnostic", "warning_diagnostic_visible", "warning_diagnostic_selected",
  "error", "error_visible", "error_selected",
  "error_diagnostic", "error_diagnostic_visible", "error_diagnostic_selected",
  "modified", "modified_visible", "modified_selected",
  "duplicate", "duplicate_visible", "duplicate_selected",
  "separator", "separator_visible", "separator_selected",
  "tab_separator", "tab_separator_selected",
  "indicator_selected", "indicator_visible",
  "pick", "pick_visible", "pick_selected",
  "offset_separator",
}
local highlights = {}
for _, k in ipairs(hl_keys) do
  highlights[k] = { bg = "NONE" }
end

local readable_fg = "#9E9E9E"
for _, k in ipairs({ "background", "buffer", "tab", "numbers", "modified", "duplicate" }) do
  highlights[k].fg = readable_fg
end

require("bufferline").setup({
  options = {
    themable = true,
    offsets = {
      { filetype = "NvimTree", text = "Explorer", highlight = "Directory", separator = true },
    },
    separator_style = "thin",
    show_buffer_close_icons = false,
    show_close_icon = false,
  },
  highlights = highlights,
})

vim.keymap.set("n", "<Tab>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
vim.keymap.set("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Previous buffer" })
vim.keymap.set("n", "<S-Right>", "<cmd>BufferLineMoveNext<cr>", { desc = "Move buffer right" })
vim.keymap.set("n", "<S-Left>", "<cmd>BufferLineMovePrev<cr>", { desc = "Move buffer left" })
