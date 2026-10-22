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
      end,
    },
  },
  {
    "LazyVim/LazyVim",
    opts = { colorscheme = "nord" },
  },
}
