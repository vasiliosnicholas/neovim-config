return {
  {
    "gbprod/nord.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      transparent = true, -- Disables background fill
      borders = true, -- Keeps border definitions crisp
      on_highlights = function(highlights, colors)
        highlights.Comment = { fg = "#B5A58C", italic = true } --original color = #7b88a1
        highlights["@comment"] = { fg = "#B5A58C", italic = true } -- original color = #7b88a1
        highlights.LineNr = { fg = "#7b88a1" } -- inactive line numbers
        highlights.CursorLineNr = { fg = "#d8dee9", bold = true } -- current line number
        highlights.LspInlayHint = { fg = "#b48ead", bg = "NONE" }
        highlights.WinSeparator = { fg = "#81a1c1", bg = "NONE" } -- window divider (original #3b4252)
        highlights.VertSplit = { fg = "#81a1c1", bg = "NONE" }
        -- transparent floating windows (hover docs, completion menu, pickers)
        for _, group in ipairs({ "NormalFloat", "FloatBorder", "Pmenu" }) do
          highlights[group] = vim.tbl_extend("force", highlights[group] or {}, { bg = "NONE" })
        end
        highlights.FloatBorder.fg = "#81a1c1" -- float/popup borders (original #4c566a)
      end,
    },
  },
  {
    "LazyVim/LazyVim",
    opts = { colorscheme = "nord" },
  },
  -- Light-mode companion to nord (same Nord palette on a Snow Storm background)
  {
    "rmehri01/onenord.nvim",
    lazy = true,
    config = function()
      -- set_options (not setup) so the theme isn't applied as a side effect of loading
      require("onenord.config").set_options({
        disable = { background = true, float_background = true }, -- transparent, like nord in dark mode
        custom_highlights = {
          LineNr = { fg = "#6E7A94" }, -- inactive line numbers (muted; was #838FA6)
          CursorLineNr = { fg = "#2E3440", style = "bold" }, -- current line number
          Pmenu = { bg = "NONE" }, -- transparent completion menu
          LspInlayHint = { bg = "NONE" }, -- no background box behind inlay hints
        },
      })
    end,
  },
  -- Follow KDE Plasma's light/dark setting (via the freedesktop portal over D-Bus)
  {
    "f-person/auto-dark-mode.nvim",
    lazy = false,
    priority = 999,
    opts = {
      set_dark_mode = function()
        vim.o.background = "dark"
        vim.cmd.colorscheme("nord")
      end,
      set_light_mode = function()
        vim.o.background = "light"
        vim.cmd.colorscheme("onenord") -- picks its light variant from 'background'
      end,
      update_interval = 3000,
      fallback = "dark",
    },
  },
}
