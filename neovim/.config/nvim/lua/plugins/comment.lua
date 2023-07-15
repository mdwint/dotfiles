return {
  "numToStr/Comment.nvim",
  config = function()
    require("Comment").setup()
    vim.api.nvim_set_keymap("n", "<c-_>", "gcc", {})
    vim.api.nvim_set_keymap("v", "<c-_>", "gccgv", {})
  end,
}
