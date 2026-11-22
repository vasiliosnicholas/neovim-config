return {
  {
    "soulis-1256/eagle.nvim",
    config = function()
      require("eagle").setup({
        keyboard_mode = true,
      })
      -- eagle overwrites the global FloatBorder with its border_color whenever its window opens,
      -- so keep border_color in sync with the current colorscheme's FloatBorder
      local function sync_border()
        local fg = vim.api.nvim_get_hl(0, { name = "FloatBorder", link = false }).fg
        if fg then
          require("eagle.config").options.border_color = string.format("#%06x", fg)
        end
      end
      sync_border()
      vim.api.nvim_create_autocmd("ColorScheme", { callback = sync_border })
      vim.o.mousemoveevent = true
      vim.keymap.set("n", "<Tab>", ":EagleWin<CR>", { noremap = true, silent = true })
    end,
  },
}
