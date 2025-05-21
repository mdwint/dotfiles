return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "mason-org/mason.nvim", opts = {} },
    {
      "mason-org/mason-lspconfig.nvim",
      opts = {
        ensure_installed = {
          "bashls",
          "clangd",
          "esbonio",
          "gopls",
          "ltex",
          "lua_ls",
          "pyright",
          "ruff",
          "rust_analyzer",
          "svelte",
          "taplo",
          "terraformls",
          "yamlls",
        },
      },
    },
    {
      "j-hui/fidget.nvim",
      tag = "legacy",
      event = "LspAttach",
      opts = {
        text = {
          spinner = "arc",
        },
      },
    },
  },
  config = function()
    local capabilities = require("cmp_nvim_lsp").default_capabilities()
    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

    local on_attach = function(client, bufnr)
      local function map(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
      local opts = { noremap = true, silent = true }

      map("n", "<leader>d", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
      map("n", "<leader>R", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
      map("n", "<leader>C", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
      map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
      map("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
      map("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)

      if client:supports_method("textDocument/formatting") then
        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        vim.api.nvim_create_autocmd("BufWritePre", {
          group = augroup,
          buffer = bufnr,
          callback = function() vim.lsp.buf.format() end,
        })
      end
    end

    vim.lsp.config("*", {
      capabilities = capabilities,
      on_attach = on_attach,
    })
  end,
}
