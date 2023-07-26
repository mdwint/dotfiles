return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },
  config = function()
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
    nnoremap <c-p> :Telescope find_files hidden=true theme=ivy<cr>
    nnoremap <leader>a :Telescope live_grep theme=ivy<cr>
    nnoremap <leader>8 :Telescope grep_string theme=ivy<cr>
    nnoremap <leader>r :Telescope lsp_references theme=ivy<cr>
    nnoremap <leader>b :Telescope buffers theme=ivy<cr>
    nnoremap <leader>h :Telescope help_tags theme=ivy<cr>
    nnoremap <leader>l :Telescope loclist theme=ivy<cr>
    nnoremap <leader>m :Telescope keymaps theme=ivy<cr>
    nnoremap z= :Telescope spell_suggest theme=ivy<cr>
    ]])
  end,
}
