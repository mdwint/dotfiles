return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
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
    local lspconfig = require("lspconfig")
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

      if client.supports_method("textDocument/formatting") then
        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        vim.api.nvim_create_autocmd("BufWritePre", {
          group = augroup,
          buffer = bufnr,
          callback = function() vim.lsp.buf.format() end,
        })
      end
    end

    local function find_python_venv()
      local path = vim.fn.getcwd()
      while path ~= "/" do
        local site = vim.fn.glob(path .. "/.venv/lib/python*/site-packages", true, true)
        if #site > 0 then return site[1] end
        path = vim.fn.fnamemodify(path, ":h")
      end
      return nil
    end

    require("mason").setup()
    require("mason-lspconfig").setup({ ---@diagnostic disable-line
      ensure_installed = {
        "bashls",
        "clangd",
        "esbonio",
        "gopls",
        "lua_ls",
        "pyright",
        "ruff",
        "rust_analyzer",
        "svelte",
        "taplo",
        "terraformls",
        "yamlls",
      },
      handlers = {
        function(server_name)
          lspconfig[server_name].setup({
            capabilities = capabilities,
            on_attach = on_attach,
          })
        end,
        pyright = function()
          lspconfig.pyright.setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = {
              pyright = {
                disableOrganizeImports = true,
              },
              python = {
                analysis = {
                  typeCheckingMode = "off",
                  extraPaths = {
                    find_python_venv(),
                  },
                },
              },
            },
          })
        end,
        lua_ls = function()
          lspconfig.lua_ls.setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = {
              Lua = {
                runtime = {
                  version = "LuaJIT",
                },
                diagnostics = {
                  globals = { "vim" },
                },
                format = {
                  enable = false,
                },
                workspace = {
                  library = vim.api.nvim_get_runtime_file("", true),
                },
                telemetry = {
                  enable = false,
                },
              },
            },
          })
        end,
        yamlls = function()
          lspconfig.yamlls.setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = {
              yaml = {
                customTags = {
                  "!env mapping",
                  "!client mapping",
                },
              },
            },
          })
        end,
      },
    })
  end,
}
