local function map(mode, l, r, opts)
  vim.keymap.set(mode, l, r, opts)
end

return {
  "lewis6991/gitsigns.nvim",
  config = function()
    local gs = require("gitsigns")
    gs.setup({
      signs = {
        add = { text = "+" },
        change = { text = "~" },
        untracked = { text = "" },
      },
      signs_staged = {
        add = { text = "+" },
        change = { text = "~" },
      },
    })

    map("n", "]c", function()
      if vim.wo.diff then
        vim.cmd.normal({ "]c", bang = true })
      else
        gs.nav_hunk("next")
      end
    end)

    map("n", "[c", function()
      if vim.wo.diff then
        vim.cmd.normal({ "[c", bang = true })
      else
        gs.nav_hunk("prev")
      end
    end)

    map("n", "<leader>ga", gs.stage_hunk)
    map("n", "<leader>gr", gs.reset_hunk)
    map("v", "<leader>ga", function()
      gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
    end)
    map("v", "<leader>gr", function()
      gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
    end)
    map("n", "<leader>gu", gs.undo_stage_hunk)
    map("n", "<leader>gA", gs.stage_buffer)
    map("n", "<leader>gR", gs.reset_buffer)
    map("n", "<leader>gp", gs.preview_hunk)
    map("n", "<leader>gd", gs.toggle_deleted)
    map("n", "<leader>gb", function()
      gs.blame_line({ full = true })
    end)
  end,
}
