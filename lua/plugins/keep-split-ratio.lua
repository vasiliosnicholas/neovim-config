-- Keep split widths proportional when the terminal emulator window is resized.
-- Heights are handled by the ProportionalHeights autocmd in config/autocmds.lua,
-- which also removes LazyVim's equalize-on-resize autocmd.
return {
  { "adlrwbr/keep-split-ratio.nvim", opts = {} },
}
