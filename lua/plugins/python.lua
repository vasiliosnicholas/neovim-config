return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        basedpyright = {
          settings = {
            basedpyright = {
              analysis = {
                autoSearchPaths = true,
                useLibraryCodeForTypes = false,
                diagnosticMode = "openFilesOnly",
              },
            },
          },
        },
      },
    },
  },
}
