return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "mfussenegger/nvim-dap-python",
    "theHamsta/nvim-dap-virtual-text",
    { "debugloop/layers.nvim", opts = {} },
  },
  keys = {
    { "<leader>D", function() DEBUG:toggle() end, desc = "Toggle debug mode" },
  },
  config = function()
    local dap = require("dap")
    local virtual_text = require("nvim-dap-virtual-text")
    virtual_text.setup()

    vim.fn.sign_define(
      "DapBreakpoint",
      { text = "⏺︎", texthl = "DiagnosticSignError" }
    )
    vim.fn.sign_define(
      "DapBreakpointCondition",
      { text = "⏺︎", texthl = "DiagnosticSignWarn" }
    )
    vim.fn.sign_define("DapStopped", { text = "→", texthl = "" })

    local set_conditional_breakpoint = function()
      dap.set_breakpoint(vim.fn.input("Condition: "))
    end

    DEBUG = Layers.mode.new("Debug mode") ---@diagnostic disable-line
    DEBUG:auto_show_help()
    DEBUG:keymaps({
      n = {
        { "c", dap.continue, { desc = "Continue (or Start)" } },
        { "r", dap.run_to_cursor, { desc = "Run to cursor" } },
        { "s", dap.step_over, { desc = "Step over" } },
        { "i", dap.step_into, { desc = "Step into" } },
        { "o", dap.step_out, { desc = "Step out" } },
        { "u", dap.up, { desc = "Frame up" } },
        { "d", dap.down, { desc = "Frame down" } },
        { "b", dap.toggle_breakpoint, { desc = "Toggle breakpoint" } },
        { "B", set_conditional_breakpoint, { desc = "Conditional break" } },
        { "v", virtual_text.toggle, { desc = "Toggle virtual text" } },
        { "<esc>", function() DEBUG:deactivate() end, { desc = "Exit this mode" } },
        { "R", dap.restart, { desc = "Restart" } },
        { "Q", dap.terminate, { desc = "Terminate" } },
      },
    })

    dap.listeners.after.event_initialized["debug_mode"] = function()
      if not DEBUG:active() then DEBUG:activate() end
    end
    dap.listeners.before.event_terminated["debug_mode"] = function()
      if DEBUG:active() then DEBUG:deactivate() end
    end

    require("dap-python").setup()
    dap.configurations.python = {
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
