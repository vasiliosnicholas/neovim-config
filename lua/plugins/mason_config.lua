return {
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        "ltex-ls-plus",
        "htmlhint",
        "html-lsp",
        "emmet-ls", -- Added Emmet Language Server
        "css-lsp",
        "stylelint",
        "csskit",
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        cssls = {},
        ltex_plus = {},
        htmlhint = {},
        html = {},
        emmet_ls = {},
        stylelint = {},
        csskit = {},
      },
    },
  },
}
