return {
  {
    "nvim-lualine/lualine.nvim",
    opts = {
      sections = {
        -- Removes the arrow-right of the mode default section
        -- lualine_a = { { "mode", separator = { left = "", right = "" } } },

        -- I don't really know what this was, so I removed it lol
        lualine_x = {},

        -- Removes the progress and location
        lualine_y = {},

        -- Removes the default clock from lualine
        lualine_z = {},
      },
    },
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      window = {
        position = "right",
      },
    },
  },
}
