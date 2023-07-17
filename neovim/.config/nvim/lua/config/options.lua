vim.o.clipboard = "unnamed"
vim.o.cursorline = true
vim.o.mouse = "a"
vim.o.scrolloff = 8
vim.o.shell = "/bin/bash"
vim.o.undofile = true

vim.o.number = true
vim.o.relativenumber = true

vim.o.splitbelow = true
vim.o.splitright = true

vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.inccommand = "nosplit"

vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.smarttab = true

vim.o.wildmenu = true
vim.o.wildmode = "longest:full,full"
vim.opt.completeopt:append({ longest })

vim.g.netrw_altv = 1
vim.g.netrw_banner = 0
vim.g.netrw_browse_split = 4
vim.g.netrw_liststyle = 3
vim.g.netrw_winsize = 20

vim.g.SuperTabDefaultCompletionType = "context"
vim.g.SuperTabClosePreviewOnPopupClose = 1
vim.o.formatexpr = ""

vim.diagnostic.config({
  underline = false,
  virtual_text = {
    prefix = "•",
    spacing = 1,
    source = "always",
  },
})

local signs = { Error = "✘", Warn = "?", Info = "i" }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl })
end
