return {

  "nvim-lua/plenary.nvim",

  -- formatting!
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
      },
    },
    config = function(_, opts)
      require("conform").setup(opts)
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
    build = ":TSUpdate",
    opts = function()
      return require "nvchad.configs.treesitter"
    end,
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "syntax")
      dofile(vim.g.base46_cache .. "treesitter")
      require("nvim-treesitter.configs").setup(opts)
    end,
  },

  -- git stuff
  {
    "lewis6991/gitsigns.nvim",
    event = "User FilePost",
    opts = function()
      return require "nvchad.configs.gitsigns"
    end,
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "git")
      require("gitsigns").setup(opts)
    end,
  },

  -- lsp stuff
  {
    "williamboman/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUpdate" },
    opts = function()
      return require "nvchad.configs.mason"
    end,
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "mason")
      require("mason").setup(opts)

      -- custom nvchad cmd to install all mason binaries listed
      vim.api.nvim_create_user_command("MasonInstallAll", function()
        if opts.ensure_installed and #opts.ensure_installed > 0 then
          vim.cmd("MasonInstall " .. table.concat(opts.ensure_installed, " "))
        end
      end, {})

      vim.g.mason_binaries_list = opts.ensure_installed
    end,
  },

  {
    "neovim/nvim-lspconfig",
    event = "User FilePost",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
    end,
  },

  -- load luasnips + cmp related in insert mode only
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      {
        -- snippet plugin
        "L3MON4D3/LuaSnip",
        dependencies = "rafamadriz/friendly-snippets",
        opts = { history = true, updateevents = "TextChanged,TextChangedI" },
        config = function(_, opts)
          require("luasnip").config.set_config(opts)
          require "nvchad.configs.luasnip"
        end,
      },

      -- autopairing of (){}[] etc
      {
        "windwp/nvim-autopairs",
        opts = {
          fast_wrap = {},
          disable_filetype = { "TelescopePrompt", "vim" },
        },
        config = function(_, opts)
          require("nvim-autopairs").setup(opts)

          -- setup cmp for autopairs
          local cmp_autopairs = require "nvim-autopairs.completion.cmp"
          require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
        end,
      },

      -- cmp sources plugins
      {
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
      },
    },
    opts = function()
      return require "nvchad.configs.cmp"
    end,
    config = function(_, opts)
      require("cmp").setup(opts)
    end,
  },

  {
    "numToStr/Comment.nvim",
    keys = {
      { "gcc", mode = "n", desc = "comment toggle current line" },
      { "gc", mode = { "n", "o" }, desc = "comment toggle linewise" },
      { "gc", mode = "x", desc = "comment toggle linewise (visual)" },
      { "gbc", mode = "n", desc = "comment toggle current block" },
      { "gb", mode = { "n", "o" }, desc = "comment toggle blockwise" },
      { "gb", mode = "x", desc = "comment toggle blockwise (visual)" },
    },
    config = function(_, opts)
      require("Comment").setup(opts)
    end,
  },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    cmd = "Telescope",
    opts = function()
      return require "nvchad.configs.telescope"
    end,
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "telescope")
      local telescope = require "telescope"
      telescope.setup(opts)

      -- load extensions
      for _, ext in ipairs(opts.extensions_list) do
        telescope.load_extension(ext)
      end
    end,
  },

  {
	  "mg979/vim-visual-multi",
	  branch = "master",
	  config = function()
		  vim.g.VM_default_mappings = 0
		-- available keymap
		  vim.api.nvim_set_keymap("n", "<C-n>", "<Plug>(VM-Find-Under)", {})
		  vim.api.nvim_set_keymap("x", "<C-n>", "<Plug>(VM-Find-Subword-Under)", {})
		  vim.api.nvim_set_keymap("n", "<C-Down>", "<Plug>(VM-Add-Cursor-Down)", {})
		  vim.api.nvim_set_keymap("n", "<C-Up>", "<Plug>(VM-Add-Cursor-Up)", {})

		-- advance keymap
		  vim.api.nvim_set_keymap("n", "<C-S-Down>", "<Plug>(VM-Select-Next)", {})
		  vim.api.nvim_set_keymap("n", "<C-S-Up>", "<Plug>(VM-Select-Prev)", {})
		  vim.api.nvim_set_keymap("n", "<C-d>", "<Plug>(VM-Remove-Cursor)", {})
		  vim.api.nvim_set_keymap("n", "<C-S-d>", "<Plug>(VM-Remove-All)", {})
		  vim.api.nvim_set_keymap("n", "<C-l>", "<Plug>(VM-Reselect-Last)", {})
		  vim.api.nvim_set_keymap("n", "<C-a>", "<Plug>(VM-Select-All)", {})
		  vim.api.nvim_set_keymap("n", "<C-/>", "<Plug>(VM-Visual-Clear)", {})
		  vim.api.nvim_set_keymap("n", "<C-Space>", "<Plug>(VM-Visual-Regex)", {})

		-- switch between cursors
		  vim.api.nvim_set_keymap("n", "n", "<Plug>(VM-Find-Under)", {})
		  vim.api.nvim_set_keymap("n", "N", "<Plug>(VM-Select-Next)", {})
		  vim.api.nvim_set_keymap("n", "p", "<Plug>(VM-Select-Prev)", {})

		-- lock and unclock the current cursor
		  vim.api.nvim_set_keymap("n", "<C-s>", "<Plug>(VM-Insert)", {})
		  vim.api.nvim_set_keymap("n", "<C-r>", "<Plug>(VM-Replace)", {})
	  end,
  },

  -- {
  --   "zbirenbaum/copilot-cmp",
  --   config = function ()
  --     require("copilot_cmp").setup()
  --   end
  -- },

  -- {
  --   "MunifTanjim/prettier.nvim",
  --   config = function()
  --     require('prettier').setup({
  --       bin = 'prettier', -- hoặc 'prettierd' nếu bạn đã cài đặt prettierd
  --       filetypes = {
  --         "css",
  --         "javascript",
  --         "javascriptreact",
  --         "typescript",
  --         "typescriptreact",
  --         "json",
  --         "scss",
  --         "less",
  --         "html",
  --         "yaml",
  --         "markdown",
  --         "graphql"
  --       },
  --     })
  --   end
  -- }
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("nvim-tree").setup {}
    end,
  },
}
