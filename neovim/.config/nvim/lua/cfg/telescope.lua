local actions = require("telescope.actions")
require("telescope").setup({
  defaults = {
    file_ignore_patterns = {
      ".git/",
      ".tox/",
      "node_modules/",
    },
    mappings = {
      i = {
        ["<esc>"] = actions.close,
      },
    },
  },
  extensions = {
    fzf = {},
  },
})
require("telescope").load_extension("fzf")

vim.cmd([[
nnoremap <c-p> :Telescope find_files hidden=true theme=get_ivy<cr>
nnoremap <leader>a :Telescope live_grep theme=get_ivy<cr>
nnoremap <leader>8 :Telescope grep_string theme=get_ivy<cr>
nnoremap <leader>b :Telescope buffers theme=get_ivy<cr>
nnoremap <leader>h :Telescope help_tags theme=get_ivy<cr>
]])
