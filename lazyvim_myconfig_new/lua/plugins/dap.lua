return {
  "rcarriga/nvim-dap-ui",
  keys = {
    {
      "<leader>dR",
      function()
        require("dapui").open({ reset = true })
      end,
      desc = "Reset UI",
    },
  },
}
