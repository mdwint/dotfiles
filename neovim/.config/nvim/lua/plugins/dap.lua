return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "mfussenegger/nvim-dap-python",
    "theHamsta/nvim-dap-virtual-text",
  },
  config = function()
    require("nvim-dap-virtual-text").setup()

    vim.fn.sign_define(
      "DapBreakpoint",
      { text = "⬤", texthl = "DiagnosticSignError" }
    )
    vim.fn.sign_define(
      "DapBreakpointCondition",
      { text = "⬤", texthl = "DiagnosticSignWarn" }
    )
    vim.fn.sign_define("DapStopped", { text = "→", texthl = "" })

    local map, opts = vim.api.nvim_set_keymap, { noremap = true }
    map("n", "<leader>D", "<cmd>DapContinue<cr>", opts)
    map("n", "<leader><space>", "<cmd>DapStepOver<cr>", opts)
    map("n", "<leader><cr>", "<cmd>DapStepInto<cr>", opts)
    map("n", "<leader><bs>", "<cmd>DapStepOut<cr>", opts)
    map("n", "<leader>c", "<cmd>lua require('dap').run_to_cursor()<cr>", opts)
    map("n", "<leader>B", "<cmd>DapToggleBreakpoint<cr>", opts)
    map(
      "n",
      "<leader>X",
      "<cmd>lua require('dap').set_breakpoint(vim.fn.input('Condition: '))<cr>",
      opts
    )
    map("n", "<leader>V", "<cmd>DapVirtualTextToggle<cr>", opts)

    require("dap-python").setup()
    require("dap").configurations.python = {
      {
        type = "python",
        request = "launch",
        name = "file",
        program = "${file}",
      },
      {
        type = "python",
        request = "launch",
        name = "file:pytest",
        module = "pytest",
        args = { "${file}" },
      },
      {
        type = "python",
        request = "attach",
        name = "attach",
        connect = function()
          local host = vim.fn.input("Host [127.0.0.1]: ")
          host = host ~= "" and host or "127.0.0.1"
          local port = tonumber(vim.fn.input("Port [5678]: ")) or 5678
          return { host = host, port = port }
        end,
      },
    }
  end,
}
