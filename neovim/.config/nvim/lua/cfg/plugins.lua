local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
vim.loader.enable()

require("lazy").setup({
  "christoomey/vim-tmux-navigator",
  "dense-analysis/ale",
  "ervandew/supertab",
  "lewis6991/gitsigns.nvim",
  "mbbill/undotree",
  "neovim/nvim-lspconfig",
  "rizzatti/dash.vim",
  "tpope/vim-fugitive",
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
      vim.api.nvim_set_keymap("n", "<c-_>", "gcc", {})
      vim.api.nvim_set_keymap("v", "<c-_>", "gccgv", {})
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-context",
    },
  },
  {
    "epwalsh/obsidian.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    lazy = true,
    event = { "BufReadPre " .. vim.fn.expand("~") .. "/notes/**.md" },
    opts = { dir = "~/notes" },
  },
})
