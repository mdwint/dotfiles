return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-neotest/neotest-python",
    "nvim-neotest/nvim-nio",
    "nvim-treesitter/nvim-treesitter",
  },
  keys = {
    {
      "<leader>tt",
      function() require("neotest").run.run() end,
      desc = "Run nearest test",
    },
    {
      "<leader>tf",
      function() require("neotest").run.run(vim.fn.expand("%")) end,
      desc = "Run all tests in file",
    },
    {
      "<leader>ts",
      function() require("neotest").summary.toggle() end,
      desc = "Toggle test summary",
    },
    {
      "<leader>twt",
      function() require("neotest").watch.toggle() end,
      desc = "Toggle watching nearest test",
    },
    {
      "<leader>twf",
      function() require("neotest").watch.toggle(vim.fn.expand("%")) end,
      desc = "Toggle watching all tests in file",
    },
  },
  config = function()
    require("neotest").setup({
      adapters = {
        require("neotest-python")({
          dap = { justMyCode = false },
        }),
      },
      icons = {
        failed = "✘",
        notify = "i",
        passed = "✓",
        running = "▶",
        skipped = "/",
        unknown = "?",
        watching = "▶",
      },
    })
  end,
}
