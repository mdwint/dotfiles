local vault = vim.fn.expand("~")
  .. "/Library/Mobile Documents/iCloud~md~obsidian/Documents/notes"

return {
  "epwalsh/obsidian.nvim",
  version = "*",
  lazy = true,
  event = {
    "BufReadPre " .. vault .. "/**.md",
    "BufNewFile " .. vault .. "/**.md",
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
    workspaces = {
      {
        name = "notes",
        path = vault,
      },
    },
    disable_frontmatter = true,
    ui = { enable = false },

    note_id_func = function(title)
      return os.date("%Y-%m-%d") .. "-" .. title:gsub(" ", "-"):lower()
    end,
  },
}
