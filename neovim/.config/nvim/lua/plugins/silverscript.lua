local root = vim.fn.expand("~/gorilla/silverscript")
if vim.fn.isdirectory(root) == 0 then return {} end

return {
  "gorillaco/silverscript",
  dir = root .. "/nvim",
}
