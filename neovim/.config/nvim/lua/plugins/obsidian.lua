return {
  "epwalsh/obsidian.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  lazy = true,
  event = { "BufReadPre " .. vim.fn.expand("~") .. "/notes/**.md" },
  opts = { dir = "~/notes" },
}
