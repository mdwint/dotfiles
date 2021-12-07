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

require("gitsigns").setup({
  signs = {
    add = { text = "+" },
    change = { text = "~" },
  },
})
