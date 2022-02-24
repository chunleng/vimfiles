vim.cmd[[
  nnoremap <silent><leader><space> :NvimTreeFindFile<cr>
  let g:nvim_tree_group_empty = 1
  let g:nvim_tree_git_hl = 1
  let g:nvim_tree_icons = {
      \ 'git': {
      \   'unstaged': "",
      \   'staged': "",
      \   'unmerged': "",
      \   'renamed': "→",
      \   'untracked': "?",
      \   'deleted': "",
      \   'ignored': "◌"
      \   }
      \ }
]]

require'nvim-tree'.setup {
  disable_netrw       = false,
  open_on_setup       = true,
  hijack_cursor       = true,
  diagnostics         = {
    enable = true,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    }
  },
  view = {
    auto_resize = true,
  },
  filters = {
    custom = { "__pycache__" }
  },
  actions = {
    open_file = {
      quit_on_open = true,
      window_picker = {
        enable = true,
        chars = "aoeuhtns",
        exclude = {
          filetype = {
            "notify",
            "packer",
            "qf",
            "Trouble"
          }
        }
      }
    }
  }
}
