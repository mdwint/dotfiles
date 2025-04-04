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
      python = { "mypy" },
      sh = {},
      yaml = {},
    }
    vim.g.ale_fix_on_save = 1
    vim.g.ale_fixers = {
      changelogmd = { "ocdc" },
      css = { "prettier" },
      html = { "prettier" },
      javascript = { "prettier" },
      json = { "prettier" },
      lua = { "stylua" },
      python = { "ruff" },
      typescript = { "prettier" },
      --yaml = { "yamlfmt" },
      ["*"] = { "remove_trailing_lines", "trim_whitespace" },
    }
    vim.g.ale_python_autoflake_options =
      "--remove-all-unused-imports --ignore-init-module-imports"
  end,
}
