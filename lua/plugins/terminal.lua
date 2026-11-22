-- Split terminals open at 20% of the editor height: half of Snacks' default (0.4).
-- Set on the "split" style (not terminal.win) so floating terminals like lazygit keep their 90% size.
return {
  "folke/snacks.nvim",
  opts = {
    styles = {
      split = { height = 0.2 },
    },
  },
}
