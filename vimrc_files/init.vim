" http://google.com
if filereadable('/usr/local/bin/python3')
    let g:python3_host_prog='/usr/local/bin/python3'
endif

if filereadable('/usr/local/bin/neovim-node-host')
    let g:node_host_prog='/usr/local/bin/neovim-node-host'
endif

if filereadable('/usr/local/bin/neovim-node-host')
    let g:ruby_host_prog='/usr/local/bin/neovim-ruby-host'
endif

" Plugins --------------------------------------------------------------- {{{
call plug#begin('~/.vim/plugged')
    " Show the menu for leader key
    Plug 'folke/which-key.nvim'

    " File navigator & plugins
    Plug 'kyazdani42/nvim-tree.lua'
    Plug 'kyazdani42/nvim-web-devicons'

    " Beautify
    Plug 'glepnir/galaxyline.nvim'
    Plug 'akinsho/nvim-bufferline.lua'
    Plug 'SmiteshP/nvim-gps'

    " Allow to view edit history
    Plug 'simnalamburt/vim-mundo', { 'on': 'MundoToggle' }
    Plug 'lukas-reineke/indent-blankline.nvim'
    Plug 'AndrewRadev/linediff.vim', { 'on': 'Linediff' }

    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-rhubarb'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'lewis6991/gitsigns.nvim'

    Plug 'SirVer/ultisnips'
    Plug 'embear/vim-localvimrc'

    " Vim test
    Plug 'vim-test/vim-test'

    " Markdown
    Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'}
    Plug 'amiorin/vim-fenced-code-blocks'

    " Parentheses formatting
    Plug 'andymass/vim-matchup'
    Plug 'windwp/nvim-autopairs'
    Plug 'windwp/nvim-ts-autotag'

    " Show highlight when there is trailing whitespace
    Plug 'bronson/vim-trailing-whitespace'

    " For Commenting
    Plug 'tpope/vim-commentary'

    " Underline all other instance of word under cursor
    Plug 'itchyny/vim-cursorword'
    Plug 'whatyouhide/vim-lengthmatters'
    Plug 'tpope/vim-surround'
    Plug 'qpkorr/vim-bufkill'

    " Fuzzy finder for files, grep and more
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'

    " Code Intellisense
    Plug 'neovim/nvim-lspconfig'
    Plug 'williamboman/nvim-lsp-installer'
    Plug 'hrsh7th/nvim-cmp'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-nvim-lsp-signature-help'
    Plug 'tzachar/cmp-tabnine', { 'do': './install.sh' }
    Plug 'hrsh7th/cmp-path'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'quangnguyen30192/cmp-nvim-ultisnips'
    Plug 'stevearc/aerial.nvim'
    Plug 'b0o/schemastore.nvim'
    Plug 'folke/trouble.nvim'

    " Colorscheme
    Plug 'chriskempson/base16-vim'

    " Scrollbar
    Plug 'dstein64/nvim-scrollview'

    " Multi cursor edit
    Plug 'mg979/vim-visual-multi'

    " TreeSitter: Better highlight and autoindent information
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'nvim-treesitter/playground'
    Plug 'JoosepAlviste/nvim-ts-context-commentstring'

    " Allow autodetect of file indent
    Plug 'tpope/vim-sleuth'

    " Rails Development
    Plug 'tpope/vim-rails'

    " For language that are not yet covered by treesitter
    Plug 'purescript-contrib/purescript-vim'

    " Additional Syntax Support
    Plug 'aklt/plantuml-syntax'

    " TODO https://github.com/puremourning/vimspector
call plug#end()
" }}}

lua << EOF
require("indent_blankline").setup {
    char = "│",
    filetype_exclude = {'WhichKey','markdown'},
    use_treesitter = true
}
require('gitsigns').setup {
    signs = {
        add          = {hl = 'GitSignsAdd'   , text = '│', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
        change       = {hl = 'GitSignsChange', text = '│', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
        delete       = {hl = 'GitSignsDelete', text = '│', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
        topdelete    = {hl = 'GitSignsDelete', text = '│', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
        changedelete = {hl = 'GitSignsChange', text = '│', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
    },
    keymaps = {
        buffer = false,
        ['n <leader>gn'] = '<cmd>lua require\"gitsigns.actions\".next_hunk()<CR>',
        ['n <leader>gp'] = '<cmd>lua require\"gitsigns.actions\".prev_hunk()<CR>',
        ['n <leader>gr'] = '<cmd>lua require\"gitsigns.actions\".reset_hunk()<CR>',
    },
    current_line_blame = true,
}
require("nvim-gps").setup()

local lsp_installer_servers = require('nvim-lsp-installer.servers')

-- configuration: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
-- installer: https://github.com/williamboman/nvim-lsp-installer#available-lsps
local servers = {
    "tsserver",
    "tailwindcss",
    "eslint",
    "pyright",
    "efm",
    "jsonls",
    "sumneko_lua",
    "jdtls",
    "vimls",
    "html",
    "emmet_ls",
    "yamlls",
    "terraformls",
    "tflint",
}

local kind_icons = {
  Text = "",
  Method = "",
  Function = "ƒ",
  Constructor = "",
  Field = "",
  Variable = "",
  Class = "",
  Interface = "",
  Module = "",
  Property = "",
  Unit = "",
  Value = "",
  Enum = "",
  Keyword = "",
  Snippet = "",
  Color = "",
  File = "",
  Reference = "",
  Folder = "",
  EnumMember = "",
  Constant = "",
  Struct = "פּ",
  Event = "",
  Operator = "",
  TypeParameter = "",
  Array = "",
  Number = "",
  Boolean = "ﰰﰴ",
  String = ""
}

local js_kind = { "Class", "Constructor", "Enum", "Function", "Interface", "Module", "Method", "Struct", "Constant", "Variable", "Field" }
local data_kind = { "Module", "Number", "Array", "Boolean", "String"}

require("aerial").setup({
  min_width = 40,
  max_width = 40,
  show_guide = true,
  icons = kind_icons,
  filter_kind = {
    ['_'] = { "Class", "Constructor", "Enum", "Function", "Interface", "Module", "Method", "Struct" },
    typescriptreact = js_kind,
    javascriptreact = js_kind,
    typescript = js_kind,
    javascript = js_kind,
    json = data_kind,
    yaml = data_kind,
  },
  default_direction = "right",
})

local signs = { Error = "", Warn = "", Hint = "ﯦ", Info = "" }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
vim.diagnostic.config({
  virtual_text = {
    prefix = '●',
    severity_sort = true,
  }
})

-- Loop through the servers listed above and set them up. If a server is
-- not already installed, install it.
for _, server_name in pairs(servers) do
    local server_available, server = lsp_installer_servers.get_server(server_name)
    if server_available then
        server:on_ready(function ()
            local keymap_opts = { noremap=true, silent=true }
            local common_on_attach = function(client, bufnr)
                vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', keymap_opts)
                vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', keymap_opts)
                vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', keymap_opts)
                vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>cf', '<cmd>lua vim.lsp.buf.code_action()<CR>', keymap_opts)
                vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>cr', '<cmd>lua vim.lsp.buf.rename()<CR>', keymap_opts)
                vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>c=', '<cmd>lua vim.lsp.buf.formatting()<CR>', keymap_opts)
                vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>cu', '<cmd>lua vim.lsp.buf.references()<CR>', keymap_opts)
                vim.api.nvim_buf_set_keymap(bufnr, 'i', '<c-space>', '<cmd>lua vim.lsp.buf.completion()<CR>', keymap_opts)
                vim.api.nvim_buf_set_keymap(bufnr, 'v', '=', ':\'<,\'>lua vim.lsp.buf.range_formatting()<CR>', keymap_opts)
                vim.api.nvim_set_keymap('n', '<leader>cd', '<cmd>Trouble document_diagnostics<CR>', keymap_opts)
                vim.api.nvim_set_keymap('n', '<leader>c?', '<cmd>Trouble workspace_diagnostics<CR>', keymap_opts)
                vim.api.nvim_set_keymap('n', '<leader>cp', '<cmd>lua vim.diagnostic.goto_prev()<CR>', keymap_opts)
                vim.api.nvim_set_keymap('n', '<leader>cn', '<cmd>lua vim.diagnostic.goto_next()<CR>', keymap_opts)
                vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>cc', '<cmd>AerialOpen<CR><cmd>AerialTreeCloseAll<CR>', keymap_opts)
                require("aerial").on_attach(client, bufnr)
            end
            local server_opts = {
                on_attach = common_on_attach,
                flags = {
                  -- This will be the default in neovim 0.7+
                  debounce_text_changes = 150,
                },
            }
            if server.name == "tsserver" then
                server_opts.on_attach = function (client, bufnr)
                    client.resolved_capabilities.document_formatting = false -- Prefer eslint
                    common_on_attach(client, bufnr)
                end
            elseif server.name == "eslint" then
                server_opts.on_attach = function (client, bufnr)
                    client.resolved_capabilities.document_formatting = true
                    common_on_attach(client, bufnr)
                end
            elseif server.name == "efm" then
                server_opts.init_options = { documentFormatting = true }
                server_opts.filetypes = { "python" }
                -- https://github.com/mattn/efm-langserver#example-for-configyaml
                -- TODO markdown-lint
                server_opts.settings = {
                  languages = {
                    python = {
                      {
                        formatCommand = "black --quiet -",
                        formatStdin = true,
                        rootMarkers = { ".python-version" }
                      },
                      {
                        formatCommand = "isort --quiet -",
                        formatStdin = true,
                        rootMarkers = { ".python-version" }
                      }
                    }
                  }
                }
            elseif server.name == "jsonls" then
              local capabilities = vim.lsp.protocol.make_client_capabilities()
              capabilities.textDocument.completion.completionItem.snippetSupport = true
              server_opts.capabilities = capabilities
              server_opts.settings = {
                json = {
                  schemas = require('schemastore').json.schemas(),
                },
              }
            elseif server.name == "html" then
              local capabilities = vim.lsp.protocol.make_client_capabilities()
              capabilities.textDocument.completion.completionItem.snippetSupport = true
              server_opts.capabilities = capabilities
            elseif server.name == "emmet_ls" then
              server_opts.filetypes = { "html", "css", "typescriptreact", "javascriptreact" }
            elseif server.name == "yamlls" then
              server_opts.settings = {
                yaml = {
                  format = {
                    enable = true
                  }
                }
              }
            end
            server:setup(server_opts)
        end)
        if not server:is_installed() then
            -- Queue the server to be installed.
            server:install()
        end
    end
end

local cmp = require'cmp'
local compare = require'cmp.config.compare'

cmp.setup({
  formatting = {
    format = function(entry, vim_item)
      local prsnt, lspkind = pcall(require, "lspkind")
        if not prsnt then
          -- Kind icons
          vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
          -- Source
          vim_item.menu = ({
            path = "│",
            ultisnips = "│",
            cmp_tabnine = "│ Tabnine",
            nvim_lsp = "│ LSP",
            buffer = "│ Buffer",
          })[entry.source.name]
          return vim_item
        else
          return lspkind.cmp_format()
        end
      end
  },
  sorting = {
    comparators = {
      compare.score,
      compare.kind,
    }
  },
  sources = {
    { name = 'path' },
    { name = 'ultisnips' },
    { name = 'cmp_tabnine' },
    { name = 'nvim_lsp_signature_help' },
    { name = 'nvim_lsp', max_item_count = 100 },
    { name = 'buffer',
      option = {
        -- https://github.com/hrsh7th/cmp-buffer#visible-buffers
        get_bufnrs = function()
          local bufs = {}
          for _, win in ipairs(vim.api.nvim_list_wins()) do
            -- TODO https://github.com/hrsh7th/cmp-buffer#performance-on-large-text-files
            bufs[vim.api.nvim_win_get_buf(win)] = true
          end
          return vim.tbl_keys(bufs)
        end
      }
    },
  },
  mapping = {
      ['<tab>'] = cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
      },
  },
  snippet = {
    expand = function(args)
      vim.fn["UltiSnips#Anon"](args.body)
    end,
  },
})

local tabnine = require('cmp_tabnine.config')
tabnine:setup({
  max_num_results = 2;
})
require("trouble").setup {}
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
require('nvim-autopairs').setup{}
cmp.event:on( 'confirm_done', cmp_autopairs.on_confirm_done({  map_char = { tex = '' } }))

EOF
let g:matchup_matchparen_offscreen = {'method': ''}

runtime before-plugin.vim

" Plugin settings ------------------------------------------------------- {{{
runtime nvim-scrollview.vim
runtime vim-visual-multi.vim
runtime nvim-treesitter.vim
runtime nvim-tree.vim
runtime mundo.vim
runtime linediff.vim
runtime vim-fugitive.vim
runtime nvim-bufferline.lua
runtime galaxyline.nvim.lua
runtime ultisnips.vim
runtime vim-localvimrc.vim
runtime vim-lengthmatters.vim
runtime vim-bufkill.vim
runtime which-key.nvim.vim
runtime fzf.vim
runtime markdown-preview.vim
runtime vim-fenced-code-blocks.vim
runtime vim-test.vim
runtime vim-rails.vim
runtime vim-sleuth.vim
runtime trailing-whitespace.vim
" }}}

runtime after-plugin.vim

" direnv settings
autocmd BufRead,BufNewFile .envrc :set ft=sh

" gray
exec "hi CmpItemMenuDefault gui=italic guifg=#".g:base16_gui03." guibg=NONE"
exec "hi CmpItemAbbrDeprecated gui=strikethrough guifg=#".g:base16_gui03." guibg=NONE"
" blue
exec "hi CmpItemAbbrMatch gui=NONE guifg=#".g:base16_gui0D." guibg=NONE"
exec "hi CmpItemAbbrMatchFuzzy gui=NONE guifg=#".g:base16_gui0D." guibg=NONE"
" orange
exec "hi CmpItemKindFunction gui=NONE guifg=#".g:base16_gui09." guibg=NONE"
exec "hi CmpItemKindMethod gui=NONE guifg=#".g:base16_gui09." guibg=NONE"
exec "hi CmpItemKindConstructor gui=NONE guifg=#".g:base16_gui09." guibg=NONE"
exec "hi CmpItemKindClass gui=NONE guifg=#".g:base16_gui09." guibg=NONE"
exec "hi CmpItemKindInterface gui=NONE guifg=#".g:base16_gui09." guibg=NONE"
exec "hi CmpItemKindModule gui=NONE guifg=#".g:base16_gui09." guibg=NONE"
exec "hi CmpItemKindEnum gui=NONE guifg=#".g:base16_gui09." guibg=NONE"
exec "hi CmpItemKindStruct gui=NONE guifg=#".g:base16_gui09." guibg=NONE"
" turquoise
exec "hi CmpItemKindVariable gui=NONE guifg=#".g:base16_gui0C." guibg=NONE"
exec "hi CmpItemKindText gui=NONE guifg=#".g:base16_gui0C." guibg=NONE"
exec "hi CmpItemKindField gui=NONE guifg=#".g:base16_gui0C." guibg=NONE"
exec "hi CmpItemKindProperty gui=NONE guifg=#".g:base16_gui0C." guibg=NONE"
exec "hi CmpItemKindValue gui=NONE guifg=#".g:base16_gui0C." guibg=NONE"
exec "hi CmpItemKindEnumMember gui=NONE guifg=#".g:base16_gui0C." guibg=NONE"
exec "hi CmpItemKindTypeParameter gui=NONE guifg=#".g:base16_gui0C." guibg=NONE"
exec "hi CmpItemKindConstant gui=NONE guifg=#".g:base16_gui0C." guibg=NONE"
" yellow
exec "hi CmpItemKindUnit gui=NONE guifg=#".g:base16_gui0A." guibg=NONE"
exec "hi CmpItemKindKeyword gui=NONE guifg=#".g:base16_gui0A." guibg=NONE"
exec "hi CmpItemKindOperator gui=NONE guifg=#".g:base16_gui0A." guibg=NONE"
exec "hi CmpItemKindColor gui=NONE guifg=#".g:base16_gui0A." guibg=NONE"
" default
exec "hi CmpItemKind gui=NONE guifg=#".g:base16_gui03." guibg=NONE"
