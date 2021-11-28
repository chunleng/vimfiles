set foldmethod=expr
" TODO uncomment when treesitter becomes much better
" set foldexpr=nvim_treesitter#foldexpr()
set foldlevelstart=99

lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained",
  highlight = { enable = true },
}
EOF
