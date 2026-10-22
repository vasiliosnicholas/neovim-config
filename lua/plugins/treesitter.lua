return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  config = function()
    local TS = require("nvim-treesitter")
    local want = { "html", "css", "javascript", "typescript", "jsx", "tsx" }
    local have = TS.get_installed()
    local missing = vim.tbl_filter(function(lang)
      return not vim.tbl_contains(have, lang)
    end, want)
    if #missing > 0 then
      TS.install(missing)
    end
  end,
}
