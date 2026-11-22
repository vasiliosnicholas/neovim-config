-- Snacks split terminals open at 20% of the editor height: half of Snacks' default (0.4)
return {
  "folke/snacks.nvim",
  opts = {
    terminal = {
      win = { height = 0.2 },
    },
  },
}
