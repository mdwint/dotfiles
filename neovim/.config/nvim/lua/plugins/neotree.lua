return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
  },
  keys = {
    { "<leader>e", "<cmd>Neotree toggle reveal<cr>", desc = "Toggle Neotree" },
  },
  opts = {
    filesystem = {
      filtered_items = {
        hide_dotfiles = false,
        never_show = {
          ".DS_Store",
          ".git",
        },
      },
    },
  },
}
