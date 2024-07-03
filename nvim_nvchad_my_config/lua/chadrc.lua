local M = {}

M.ui = {
  theme = "chadracula-evondev",
  transparency = true,
  statusline = {
    theme = "default"
  },
  -- hl_override = {
  --   Comment = { italic = true },
  --   ["@comment"] = { italic = true },
  -- },
}

M.plugins = {
  options = {
    nvimtree = {
      show_dotfiles = 1,  -- Hiển thị dotfiles
    },
  },
}

local function toggle_dotfiles()
  local show = vim.g.nvim_tree_show_dotfiles
  vim.g.nvim_tree_show_dotfiles = not show
  require'nvim-tree'.refresh()
end

vim.api.nvim_set_keymap('n', '<A-/>', ':lua toggle_dotfiles()<CR>', { noremap = true, silent = true })

return M
