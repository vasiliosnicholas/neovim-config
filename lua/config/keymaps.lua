-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set({ "n", "v" }, "<A-ScrollWheelDown>", "6zl")
vim.keymap.set({ "n", "v" }, "<A-ScrollWheelUp>", "6zh")
-- Alt + operation to delete text WITHOUT copying to the system clipboard
vim.keymap.set({ "n", "v" }, "<A-d>", '"_d', { desc = "Delete without copying" })
vim.keymap.set({ "n", "v" }, "<A-D>", '"_D', { desc = "Delete line without copying" })
vim.keymap.set({ "n", "v" }, "<A-c>", '"_c', { desc = "Change without copying" })
vim.keymap.set({ "n", "v" }, "<A-x>", '"_x', { desc = "Delete char without copying" })
vim.keymap.set("v", "<A-p>", '"_dP', { desc = "Paste over selection without copying" })
-- Toggle ONLY diagnostic virtual text (inline error text)
vim.keymap.set("n", "<leader>uv", function()
  local current_config = vim.diagnostic.config()
  local is_on = current_config and current_config.virtual_text
  vim.diagnostic.config({ virtual_text = not is_on })
end, { desc = "Toggle Virtual Text (Inline Errors)" })
