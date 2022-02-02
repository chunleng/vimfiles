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

lua << EOF
require'nvim-tree'.setup {
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
  }
}
EOF
