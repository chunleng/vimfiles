set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set foldlevelstart=99

lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained",
  highlight = { enable = true },
  indent = { enable = true },
  playground = { enable = true}
}
EOF
