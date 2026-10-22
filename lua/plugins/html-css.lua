return {
  {
    "Jezda1337/nvim-html-css",
    dependencies = {
      "saghen/blink.cmp", -- If using modern LazyVim default completion
      "nvim-treesitter/nvim-treesitter",
    },
    -- The "init" function runs BEFORE the plugin starts loading
    init = function()
      local native_set_extmark = vim.api.nvim_buf_set_extmark
      vim.api.nvim_buf_set_extmark = function(buf, ns, line, col, opts)
        local success, result = pcall(native_set_extmark, buf, ns, line, col, opts)
        if not success then
          return nil -- Silently swallows the plugin's math crash
        end
        return result
      end
    end,
    opts = {
      enable_on = { "html", "tsx", "jsx", "astro", "vue", "svelte" },
    },
  },
}
