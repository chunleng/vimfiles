set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set foldlevelstart=99

lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained",
  highlight = { enable = true },
  matchup = { enable = true },
  autotag = { enable = true },
  -- indent = { enable = true },
  playground = { enable = true },
  context_commentstring = { enable = true }
}
EOF
