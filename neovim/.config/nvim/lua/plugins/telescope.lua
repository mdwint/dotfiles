return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    -- { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-telescope/telescope-ui-select.nvim",
  },
  keys = {
    { "<c-p>", ":Telescope find_files hidden=true theme=ivy<cr>" },
    { "<leader>a", ":Telescope live_grep theme=ivy<cr>" },
    { "<leader>8", ":Telescope grep_string theme=ivy<cr>" },
    { "<leader>r", ":Telescope lsp_references theme=ivy<cr>" },
    { "<leader>b", ":Telescope buffers theme=ivy<cr>" },
    { "<leader>h", ":Telescope help_tags theme=ivy<cr>" },
    { "z=", ":Telescope spell_suggest theme=cursor<cr>" },
  },
  config = function()
    local actions = require("telescope.actions")
    local themes = require("telescope.themes")

    require("telescope").setup({
      defaults = {
        file_ignore_patterns = {
          ".git/",
          ".tox/",
          "node_modules/",
        },
        mappings = {
          i = {
            ["<esc>"] = actions.close,
          },
        },
      },
      extensions = {
        -- fzf = {},
        ["ui-select"] = {
          themes.get_cursor(),
        },
      },
    })

    -- require("telescope").load_extension("fzf")
    require("telescope").load_extension("ui-select")
  end,
}
