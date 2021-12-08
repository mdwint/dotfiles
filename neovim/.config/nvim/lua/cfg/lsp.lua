local on_attach = function(client)
  local function buf_set_keymap(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end

  local opts = { noremap = true, silent = true }
  buf_set_keymap("n", "<leader>d", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  buf_set_keymap("n", "<leader>r", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  buf_set_keymap("n", "<leader>k", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  buf_set_keymap("n", "<leader>t", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
  buf_set_keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
  buf_set_keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)

  if client.resolved_capabilities.document_formatting then
    vim.cmd([[
      augroup lsp_buf_format
        au! BufWritePre <buffer>
        autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
      augroup END
    ]])
  end
end

local null_ls = require("null-ls")
local diag = null_ls.builtins.diagnostics
local fmt = null_ls.builtins.formatting
null_ls.config({
  -- debug = true,
  sources = {
    -- Python:
    diag.flake8,
    diag.mypy,
    fmt.black,
    fmt.isort,

    -- Various:
    fmt.rustfmt,
    fmt.goimports,
    fmt.terraform_fmt,
    fmt.stylua,
    fmt.zigfmt,
    diag.yamllint,
    fmt.prettier.with({ disabled_filetypes = { "yaml", "markdown" } }),
    diag.proselint.with({ filetypes = { "markdown", "rst", "tex" } }),

    -- Defaults:
    fmt.trim_newlines,
    fmt.trim_whitespace,
  },
})

local servers = {
  "jedi_language_server",
  "rust_analyzer",
  "terraformls",
  "null-ls",
}
for _, lsp in ipairs(servers) do
  require("lspconfig")[lsp].setup({
    on_attach = on_attach,
  })
end

require("trouble").setup({
  icons = false,
})
local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap("n", "<leader>q", "<cmd>Trouble<cr>", opts)

require("nvim-treesitter.configs").setup({
  ensure_installed = "maintained",
  highlight = { enable = true },
})