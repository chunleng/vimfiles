vim.cmd[[
  set foldmethod=expr
  set foldexpr=nvim_treesitter#foldexpr()
  set foldlevelstart=99
]]

require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained",
  highlight = { enable = true },
  matchup = { enable = true },
  -- Disabled because plugin is still unstable
  -- indent = { enable = true },
  playground = { enable = true },
  context_commentstring = { enable = true }
}
