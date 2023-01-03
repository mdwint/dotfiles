local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local on_attach = function(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
  vim.g.SuperTabDefaultCompletionType = "context"
  vim.opt.formatexpr = ""

  local function buf_set_keymap(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end

  local opts = { noremap = true, silent = true }
  buf_set_keymap("n", "<leader>d", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  buf_set_keymap("n", "<leader>r", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  buf_set_keymap("n", "<leader>k", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  buf_set_keymap("n", "<leader>R", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  buf_set_keymap("n", "<leader>t", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
  buf_set_keymap("n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
  buf_set_keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
  buf_set_keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)

  if client.supports_method("textDocument/formatting") then
    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = augroup,
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format()
      end,
    })
  end
end

local null_ls = require("null-ls")
local diag = null_ls.builtins.diagnostics
local fmt = null_ls.builtins.formatting
null_ls.setup({
  -- debug = true,
  sources = {
    -- Python:
    diag.flake8.with({ prefer_local = ".venv/bin" }),
    diag.mypy.with({ prefer_local = ".venv/bin" }),
    fmt.black.with({ prefer_local = ".venv/bin" }),
    fmt.isort.with({ prefer_local = ".venv/bin" }),

    -- Various:
    fmt.rustfmt,
    fmt.goimports,
    fmt.terraform_fmt,
    fmt.stylua,
    fmt.zigfmt,
    -- diag.yamllint,
    fmt.ocdc,
    fmt.prettier.with({ disabled_filetypes = { "yaml", "markdown" } }),
    diag.proselint.with({ filetypes = { "markdown", "rst", "tex" } }),
    diag.commitlint,

    -- Defaults:
    fmt.trim_newlines,
    fmt.trim_whitespace,
  },
  on_attach = on_attach,
})

local lspconfig = require("lspconfig")

lspconfig.jedi_language_server.setup({
  on_attach = on_attach,
  init_options = {
    diagnostics = {
      enable = false,
    },
    workspace = {
      extraPaths = {
        ".venv/lib/python3.8/site-packages",
        ".venv/lib/python3.9/site-packages",
        ".venv/lib/python3.10/site-packages",
      },
    },
  },
})

local servers = {
  "rust_analyzer",
  "terraformls",
}
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup({
    on_attach = on_attach,
  })
end

require("nvim-treesitter.configs").setup({
  ensure_installed = {
    "bash",
    "css",
    "fish",
    "go",
    "html",
    "javascript",
    "json",
    "make",
    "python",
    "rst",
    "rust",
    "toml",
    "yaml",
  },
  highlight = { enable = true },
})
