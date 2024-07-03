vim.g.base46_cache = vim.fn.stdpath "data" .. "/nvchad/base46/"
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
    config = function()
      require "options"
    end,
  },

  { import = "plugins" },
  -- { import = "custom.plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require("nvchad.autocmds")

vim.schedule(function()
  require "mappings"
end)

-- -- Set up autocmd to define file when saved
-- vim.api.nvim_exec([[
--   augroup PrettierAutogroup
--     autocmd!
--     autocmd BufWritePost *.js,*.ts,*.jsx,*.tsx,*.css,*.html,*.json,*.md PrettierAsync
--   augroup END
-- ]], true)
-- Khởi tạo biến nếu chưa có
vim.g.nvim_tree_show_dotfiles = vim.g.nvim_tree_show_dotfiles or false

-- Định nghĩa hàm toggle_dotfiles
local function toggle_dotfiles()
  local show = vim.g.nvim_tree_show_dotfiles
  vim.g.nvim_tree_show_dotfiles = not show
  require'nvim-tree'.refresh()
end

vim.api.nvim_set_keymap('n', '<leader>d', ':lua toggle_dotfiles()<CR>', { noremap = true, silent = true })

-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

-- empty setup using defaults
require("nvim-tree").setup()

-- OR setup with some options
require("nvim-tree").setup({
  sort = {
    sorter = "case_sensitive",
  },
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})
