-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
vim.api.nvim_create_augroup("DashboardAutoOpen", { clear = true })

vim.api.nvim_create_autocmd("BufDelete", {
  group = "DashboardAutoOpen",
  callback = function()
    vim.schedule(function()
      local buffers = vim.tbl_filter(function(buf)
        return vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].buflisted and vim.api.nvim_buf_get_name(buf) ~= ""
      end, vim.api.nvim_list_bufs())

      if #buffers == 0 then
        Snacks.dashboard.open()
      end
    end)
  end,
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.svelte",
  callback = function()
    vim.treesitter.start()
  end,
})

-- vim.api.nvim_create_autocmd("ColorScheme", {
--   callback = function()
--     vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
--     vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#8AAAE5" })
--   end,
-- })
