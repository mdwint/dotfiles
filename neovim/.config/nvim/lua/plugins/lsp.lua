return {
  "neovim/nvim-lspconfig",
  config = function()
    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

    local on_attach = function(client, bufnr)
      vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
      vim.g.SuperTabDefaultCompletionType = "context"
      vim.g.SuperTabClosePreviewOnPopupClose = 1
      vim.opt.formatexpr = ""

      local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
      end

      local opts = { noremap = true, silent = true }
      buf_set_keymap("n", "<leader>d", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
      buf_set_keymap("n", "<leader>R", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
      buf_set_keymap("n", "<leader>C", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
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

    local lspconfig = require("lspconfig")

    lspconfig.jedi_language_server.setup({
      on_attach = on_attach,
      init_options = {
        diagnostics = {
          enable = false,
        },
        workspace = {
          extraPaths = {
            ".venv/lib/python3.9/site-packages",
            ".venv/lib/python3.10/site-packages",
            ".venv/lib/python3.11/site-packages",
          },
        },
      },
    })

    local servers = {
      "rust_analyzer",
      "svelte",
      "terraformls",
    }
    for _, lsp in ipairs(servers) do
      lspconfig[lsp].setup({
        on_attach = on_attach,
      })
    end

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
  end,
}
