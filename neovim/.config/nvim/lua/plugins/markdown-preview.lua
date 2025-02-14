local ft = { "markdown", "changelogmd" }
return {
  "iamcco/markdown-preview.nvim",
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  build = "cd app && npm install",
  init = function() vim.g.mkdp_filetypes = ft end,
  ft = ft,
}
