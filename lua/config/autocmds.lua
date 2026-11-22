-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
vim.api.nvim_create_augroup("DashboardAutoOpen", { clear = true })

vim.api.nvim_create_autocmd("BufDelete", {
  group = "DashboardAutoOpen",
  callback = function()
    vim.schedule(function()
      local buffers = vim.tbl_filter(function(buf)
        return vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].buflisted and vim.api.nvim_buf_get_name(buf) ~= ""
      end, vim.api.nvim_list_bufs())

      if #buffers == 0 then
        Snacks.dashboard.open()
      end
    end)
  end,
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.svelte",
  callback = function()
    vim.treesitter.start()
  end,
})

-- Don't equalize all splits when the terminal emulator window is resized (LazyVim default);
-- keep-split-ratio.nvim (widths) and the autocmd below (heights) scale them proportionally instead
vim.api.nvim_del_augroup_by_name("lazyvim_resize_splits")

-- Scale split heights proportionally when Neovim's screen size changes
-- (keep-split-ratio.nvim only handles widths)
do
  local group = vim.api.nvim_create_augroup("ProportionalHeights", { clear = true })
  -- per tab: `base` is the last layout you made yourself, `applied` is what rescale() last produced.
  -- Scaling always starts from `base`, so repeated resizes don't accumulate rounding errors.
  local layouts = {} ---@type table<integer, {base: table, applied?: table}>

  -- rows available to windows (the command line, tabline and global statusline don't scale)
  local function avail_rows()
    local tabline = (vim.o.showtabline == 2 or (vim.o.showtabline == 1 and #vim.api.nvim_list_tabpages() > 1)) and 1 or 0
    return vim.o.lines - vim.o.cmdheight - tabline - (vim.o.laststatus == 3 and 1 or 0)
  end

  local function capture(tab)
    local heights = {}
    for _, win in ipairs(vim.api.nvim_tabpage_list_wins(tab)) do
      if vim.api.nvim_win_get_config(win).relative == "" then -- skip floating windows
        heights[win] = vim.api.nvim_win_get_height(win)
      end
    end
    return { rows = avail_rows(), heights = heights }
  end

  local function snapshot()
    local tab = vim.api.nvim_get_current_tabpage()
    local current, layout = capture(tab), layouts[tab]
    if layout and layout.applied and vim.deep_equal(current, layout.applied) then
      return -- this is just the result of our own rescale; keep the base
    end
    layouts[tab] = { base = current }
  end

  local function rescale()
    local tab = vim.api.nvim_get_current_tabpage()
    local layout = layouts[tab]
    if not layout or (layout.applied or layout.base).rows == avail_rows() then
      return
    end
    local scale = avail_rows() / layout.base.rows
    for _ = 1, 2 do -- twice, because resizing one window can nudge its neighbours
      for win, h in pairs(layout.base.heights) do
        if vim.api.nvim_win_is_valid(win) then
          vim.api.nvim_win_set_height(win, math.max(1, math.floor(h * scale + 0.5)))
        end
      end
    end
    layout.applied = capture(tab)
  end

  vim.api.nvim_create_autocmd("WinResized", { group = group, callback = snapshot })
  -- scheduled so it runs after every other VimResized handler (LazyVim's equalize, keep-split-ratio)
  vim.api.nvim_create_autocmd("VimResized", { group = group, callback = vim.schedule_wrap(rescale) })
  vim.api.nvim_create_autocmd("TabEnter", {
    group = group,
    callback = function()
      if layouts[vim.api.nvim_get_current_tabpage()] then
        rescale()
      else
        snapshot()
      end
    end,
  })
  snapshot()
end

-- Snacks terminal splits: remember the height when the window closes/hides, and reopen at that height.
-- (The terminal object survives hiding, so storing it in its window opts is enough.)
vim.api.nvim_create_autocmd("WinClosed", {
  group = vim.api.nvim_create_augroup("TermRememberHeight", { clear = true }),
  callback = function(args)
    local win = tonumber(args.match)
    if not (win and vim.api.nvim_win_is_valid(win)) or vim.api.nvim_win_get_config(win).relative ~= "" then
      return -- invalid or floating window
    end
    -- match by buffer: snacks clears term.win before it closes the window on hide
    local buf = vim.api.nvim_win_get_buf(win)
    for _, term in ipairs(Snacks.terminal.list()) do
      if term.buf == buf and (term.opts.position == "bottom" or term.opts.position == "top") then
        term.opts.height = vim.api.nvim_win_get_height(win)
      end
    end
  end,
})

-- vim.api.nvim_create_autocmd("ColorScheme", {
--   callback = function()
--     vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
--     vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#8AAAE5" })
--   end,
-- })
