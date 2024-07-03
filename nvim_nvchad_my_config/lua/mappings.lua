local map = vim.keymap.set
local opts = { noremap = true, silent = true }

map("i", "<C-b>", "<ESC>^i", { desc = "move beginning of line" })
map("i", "<C-e>", "<End>", { desc = "move end of line" })
map("i", "<C-h>", "<Left>", { desc = "move left" })
map("i", "<C-l>", "<Right>", { desc = "move right" })
map("i", "<C-j>", "<Down>", { desc = "move down" })
map("i", "<C-k>", "<Up>", { desc = "move up" })

map("n", "U", "<C-r>")
map("n", "<Esc>", "<cmd>noh<CR>", { desc = "general clear highlights" })

map("n", "<C-h>", "<C-w>h", { desc = "switch window left" })
map("n", "<C-l>", "<C-w>l", { desc = "switch window right" })
map("n", "<C-j>", "<C-w>j", { desc = "switch window down" })
map("n", "<C-k>", "<C-w>k", { desc = "switch window up" })

map("n", "<C-s>", "<cmd>w<CR>", { desc = "file save" })
map("n", "<C-c>", "<cmd>%y+<CR>", { desc = "file copy whole" })

map("n", "<leader>n", "<cmd>set nu!<CR>", { desc = "toggle line number" })
map("n", "<leader>rn", "<cmd>set rnu!<CR>", { desc = "toggle relative number" })
map("n", "<leader>ch", "<cmd>NvCheatsheet<CR>", { desc = "toggle nvcheatsheet" })

map("n", "x", '"_x')
map("n", "<Leader>p", '"2p')
map("n", "<Leader>P", '"2P')
map("v", "<Leader>p", '"2p')
map("n", "<Leader>c", '"_c')
map("n", "<Leader>C", '"_C')
map("v", "<Leader>c", '"_c')
map("v", "<Leader>C", '"_C')
map("n", "<Leader>d", '"_d')
map("n", "<Leader>D", '"_D')
map("v", "<Leader>d", '"_d')
map("v", "<Leader>D", '"_D')

-- Replace text using <leader>s and <leader>S to avoid conflicts with the default behavior of s and S
map("n", "<leader>r", ':s//g<left><left>', opts) -- Line
map("n", "<leader>R", ':%s//g<left><left>', opts) -- All
map("v", "<leader>r", ':s//g<left><lefl>', opts) -- Selection

-- Increment/decrement
map("n", "+", "<C-a>")
map("n", "-", "<C-x>")

-- Delete a word backwards
map("n", "dw", 'vb"_d')

-- Select all
map("n", "<C-a>", "gg<S-v>G")

-- Save with root permission (not working for now)
--vim.api.nvim_create_user_command('W', 'w !sudo tee > /dev/null %', {})

-- Disable continuations
map("n", "<Leader>o", "o<Esc>^Da", opts)
map("n", "<Leader>O", "O<Esc>^Da", opts)

-- Jumplist
map("n", "<C-m>", "<C-i>", opts)

-- New tab
map("n", "te", ":tabedit")
map("n", "<tab>", ":tabnext<Return>", opts)
map("n", "<s-tab>", ":tabprev<Return>", opts)
-- Split window
map("n", "ss", ":split<Return>", opts)
map("n", "sv", ":vsplit<Return>", opts)

map("n", "<leader>fm", function()
  require("conform").format { lsp_fallback = true }
end, { desc = "format files" })

-- global lsp mappings
map("n", "<leader>ds", vim.diagnostic.setloclist, { desc = "lsp diagnostic loclist" })

-- tabufline
map("n", "<leader>b", "<cmd>enew<CR>", { desc = "buffer new" })

map("n", "<tab>", function()
  require("nvchad.tabufline").next()
end, { desc = "buffer goto next" })

map("n", "<S-tab>", function()
  require("nvchad.tabufline").prev()
end, { desc = "buffer goto prev" })

map("n", "<leader>x", function()
  require("nvchad.tabufline").close_buffer()
end, { desc = "buffer close" })

-- Comment
map("n", "<leader>/", function()
  require("Comment.api").toggle.linewise.current()
end, { desc = "comment toggle" })

map(
  "v",
  "<leader>/",
  "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
  { desc = "comment toggle" }
)

-- nvimtree
map("n", "<C-b>", "<cmd>NvimTreeToggle<CR>", { desc = "nvimtree toggle window" })
map("n", "<leader>e", "<cmd>NvimTreeFocus<CR>", { desc = "nvimtree focus window" })

-- telescope
map("n", "<leader>fw", "<cmd>Telescope live_grep<CR>", { desc = "telescope live grep" })
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "telescope find buffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "telescope help page" })
map("n", "<leader>ma", "<cmd>Telescope marks<CR>", { desc = "telescope find marks" })
map("n", "<leader>fo", "<cmd>Telescope oldfiles<CR>", { desc = "telescope find oldfiles" })
map("n", "<leader>fz", "<cmd>Telescope current_buffer_fuzzy_find<CR>", { desc = "telescope find in current buffer" })
map("n", "<leader>cm", "<cmd>Telescope git_commits<CR>", { desc = "telescope git commits" })
map("n", "<leader>gt", "<cmd>Telescope git_status<CR>", { desc = "telescope git status" })
map("n", "<leader>pt", "<cmd>Telescope terms<CR>", { desc = "telescope pick hidden term" })
map("n", "<leader>th", "<cmd>Telescope themes<CR>", { desc = "telescope nvchad themes" })
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "telescope find files" })
map(
  "n",
  "<leader>fa",
  "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>",
  { desc = "telescope find all files" }
)

-- terminal
map("t", "<C-x>", "<C-\\><C-N>", { desc = "terminal escape terminal mode" })

-- new terminals
map("n", "<leader>h", function()
  require("nvchad.term").new { pos = "sp" }
end, { desc = "terminal new horizontal term" })

map("n", "<leader>v", function()
  require("nvchad.term").new { pos = "vsp" }
end, { desc = "terminal new vertical window" })

-- toggleable
map({ "n", "t" }, "<A-v>", function()
  require("nvchad.term").toggle { pos = "vsp", id = "vtoggleTerm" }
end, { desc = "terminal toggleable vertical term" })

map({ "n", "t" }, "<A-h>", function()
  require("nvchad.term").toggle { pos = "sp", id = "htoggleTerm" }
end, { desc = "terminal new horizontal term" })

map({ "n", "t" }, "<C-i>", function()
  require("nvchad.term").toggle { pos = "float", id = "floatTerm" }
end, { desc = "terminal toggle floating term" })

-- whichkey
map("n", "<leader>wK", "<cmd>WhichKey <CR>", { desc = "whichkey all keymaps" })

map("n", "<leader>wk", function()
  vim.cmd("WhichKey " .. vim.fn.input "WhichKey: ")
end, { desc = "whichkey query lookup" })

-- blankline
map("n", "<leader>cc", function()
  local config = { scope = {} }
  config.scope.exclude = { language = {}, node_type = {} }
  config.scope.include = { node_type = {} }
  local node = require("ibl.scope").get(vim.api.nvim_get_current_buf(), config)

  if node then
    local start_row, _, end_row, _ = node:range()
    if start_row ~= end_row then
      vim.api.nvim_win_set_cursor(vim.api.nvim_get_current_win(), { start_row + 1, 0 })
      vim.api.nvim_feedkeys("_", "n", true)
    end
  end
end, { desc = "blankline jump to current context" })

-- Option `⌥` called `Alt` or `⌥`
-- navigation
map("n", "<A-Left>", "b", opts)
map("n", "<A-Right>", "e", opts)

map("n", "<A-Up>", "gg", opts)
map("n", "<A-Down>", "G", opts)

map("n", "<A-o>", "o<Esc>", opts)
map("n", "<A-O>", "O<Esc>", opts)

map("i", "<A-Backspace>", "<C-w>", opts)

map("i", "<A-Left>", "<Esc>bi", opts)
map("i", "<A-Right>", "<Esc>ea", opts)
map("i", "<A-Up>", "<Esc>ggA", opts)
map("i", "<A-Down>", "<Esc>GA", opts)

-- Command `⌘` called `Meta` or `⌘`
-- save file 
map("n", "<D-s>", ":w<CR>", opts)
map("i", "<D-s>", "<Esc>:w<CR>", opts)

-- close Neovim
map("n", "<D-q>", ":q<CR>", opts)
map("i", "<D-q>", "<Esc>:q<CR>", opts)

-- close current buffer
map("n", "<D-w>", ":bd<CR>", opts)
map("i", "<D-w>", "<Esc>:bd<CR>", opts)

-- open new file
map("n", "<D-o>", ":e ", { noremap = true, silent = false })  -- open picker file that don't need autocommand
map("i", "<D-o>", "<Esc>:e ", { noremap = true, silent = false })

-- navigation between buffers
map("n", "<D-Left>", ":bprevious<CR>", opts)
map("n", "<D-Right>", ":bnext<CR>", opts)

-- navigation between tabs
map("n", "<D-1>", "1gt", opts)
map("n", "<D-2>", "2gt", opts)
map("n", "<D-3>", "3gt", opts)
map("n", "<D-4>", "4gt", opts)
map("n", "<D-5>", "5gt", opts)
map("n", "<D-6>", "6gt", opts)
map("n", "<D-7>", "7gt", opts)
map("n", "<D-8>", "8gt", opts)
map("n", "<D-9>", "9gt", opts)

-- create new tab and transfer to this tab
map("n", "<D-t>", ":tabnew<CR>", opts)
map("n", "<D-w>", ":tabclose<CR>", opts)

local function my_on_attach(bufnr)
  local api = require "nvim-tree.api"

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  -- default mappings
  api.config.mappings.default_on_attach(bufnr)

  -- custom mappings
  vim.keymap.set('n', '<C-t>', api.tree.change_root_to_parent,        opts('Up'))
  vim.keymap.set('n', '?',     api.tree.toggle_help,                  opts('Help'))
end

-- pass to setup along with your other options
require("nvim-tree").setup {
  ---
  on_attach = my_on_attach,
  ---
}
