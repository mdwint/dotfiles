return {
  "dense-analysis/ale",
  config = function()
    vim.filetype.add({
      filename = {
        ["CHANGELOG.md"] = "changelogmd",
      },
    })

    vim.cmd([[
    function! OcdcFormat(buffer) abort
      return {'command': 'ocdc --path -'}
    endfunction
    ]])
    vim.fn["ale#fix#registry#Add"]("ocdc", "OcdcFormat", { "changelogmd" }, "ocdc")

    vim.g.ale_use_neovim_diagnostics_api = 1
    vim.g.ale_disable_lsp = 1
    vim.g.ale_linters = {
      sh = {}, -- Handled by LSP
    }
    vim.g.ale_fix_on_save = 1
    vim.g.ale_fixers = {
      changelogmd = { "ocdc" },
      css = { "prettier" },
      go = { "gofmt" },
      html = { "prettier" },
      javascript = { "prettier" },
      json = { "prettier" },
      lua = { "stylua" },
      packer = { "packer" },
      python = { "isort", "black" },
      rust = { "rustfmt" },
      scss = { "prettier" },
      svelte = { "prettier" },
      terraform = { "terraform" },
      typescript = { "prettier" },
      ["*"] = { "remove_trailing_lines", "trim_whitespace" },
    }
    vim.g.ale_lua_stylua_options = "--config-path ~/.config/nvim/stylua.toml"
    vim.g.ale_python_autoimport_options = "--ignore-init-modules"
  end,
}
