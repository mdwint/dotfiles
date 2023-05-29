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
  "ervandew/supertab",
  "jose-elias-alvarez/null-ls.nvim",
  "lewis6991/gitsigns.nvim",
  "mbbill/undotree",
  "neovim/nvim-lspconfig",
  "numToStr/Comment.nvim",
  "rizzatti/dash.vim",
  "sheerun/vim-polyglot",
  "tpope/vim-fugitive",
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
