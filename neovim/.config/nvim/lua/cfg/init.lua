require("cfg.plugins")
require("cfg.lsp")
require("cfg.signs")
require("cfg.telescope")

require("Comment").setup()
vim.api.nvim_set_keymap("n", "<c-_>", "gcc", {})
vim.api.nvim_set_keymap("v", "<c-_>", "gccgv", {})
