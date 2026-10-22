return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters = {
        prettier = {
          condition = function(_, ctx)
            -- disable prettier in conform if eslint-plugin-prettier is handling it
            local has_plugin = vim.fs.find("node_modules/eslint-plugin-prettier", {
              path = ctx.dirname,
              upward = true,
            })
            if #has_plugin > 0 then
              return false
            end
            return true
          end,
        },
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        vtsls = {
          on_attach = function(client, bufnr)
            local has_plugin = vim.fs.find("node_modules/eslint-plugin-prettier", {
              path = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(bufnr), ":h"),
              upward = true,
            })
            if #has_plugin > 0 then
              client.server_capabilities.documentFormattingProvider = false
              client.server_capabilities.documentRangeFormattingProvider = false
            end
          end,
        },
      },
    },
  },
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewFileHistory" },
    opts = {},
  },
}
