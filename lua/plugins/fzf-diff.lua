return {
  "ibhagwan/fzf-lua", -- Targets your existing fzf-lua installation without modifying it
  keys = {
    {
      "<leader>fd",
      function()
        local fzf = require("fzf-lua")
        fzf.files({
          prompt = "Diff With> ",
          actions = {
            -- Overrides default open behavior to use clean vertical diffsplit
            ["default"] = function(selected)
              -- Selected comes back as an array, extract the filename safely
              local filename = fzf.path.entry_to_file(selected[1]).path
              if filename then
                vim.cmd("vert diffsplit " .. vim.fn.fnameescape(filename))
              end
            end,
          },
        })
      end,
      desc = "Diff current file with picker selection",
    },
  },
}
