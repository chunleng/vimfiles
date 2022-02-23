vim.cmd [[
" /usr/local:x86 /opt/homebrew:apple silicon
if filereadable('/usr/local/bin/python3')
    let g:python3_host_prog='/usr/local/bin/python3'
endif
if filereadable('/opt/homebrew/bin/python3')
    let g:python3_host_prog='/opt/homebrew/bin/python3'
endif

if filereadable('/usr/local/bin/neovim-node-host')
    let g:node_host_prog='/usr/local/bin/neovim-node-host'
endif
if filereadable('/opt/homebrew/bin/neovim-node-host')
    let g:node_host_prog='/opt/homebrew/bin/neovim-node-host'
endif

if filereadable('/usr/local/bin/neovim-ruby-host')
    let g:ruby_host_prog='/usr/local/bin/neovim-ruby-host'
endif
runtime src/before-plugin.vim
]]

require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    use {'folke/which-key.nvim', config = function ()
        vim.cmd[[set timeoutlen=200]]
        local wk = require("which-key")
        wk.register({
            b = { name = "buffer" },
            c = {
                name = "code",
                t = { name = "test" }
            },
            g = { name = "git" },
            t = { name = "toggle" },
        }, { prefix = "<leader>" })
    end}
    use {'kyazdani42/nvim-tree.lua', config = function ()
        require('nvim-tree-config')
    end, requires = 'kyazdani42/nvim-web-devicons'}

    -- Beautify
    use {'glepnir/galaxyline.nvim', config = function ()
        require("galaxyline-nvim-config")
    end}
    use {'akinsho/nvim-bufferline.lua', config = function ()
        require("bufferline").setup{
            options = {
                show_buffer_close_icons = false,
                show_close_icon = false,
                separator_style = "slant",
            }
        }
    end}
    use {'SmiteshP/nvim-gps', config = function ()
        require("nvim-gps").setup()
    end, requires = "nvim-treesitter/nvim-treesitter"}

    -- Allow to view edit history
    use {'simnalamburt/vim-mundo', config = function ()
        vim.cmd[[
            nnoremap <leader>u :MundoToggle<cr>

            let g:mundo_width = 30
            let g:mundo_right = 1
            let g:mundo_header = 0
        ]]
    end}
    use {'lukas-reineke/indent-blankline.nvim', config = function ()
        require("indent_blankline").setup {
            char = "│",
            filetype_exclude = { 'WhichKey', 'markdown' },
            use_treesitter = true
        }
    end}
    use {'AndrewRadev/linediff.vim', config= function ()
        vim.cmd[[vnoremap <silent><leader>d :Linediff<cr>]]
    end}

    use {'tpope/vim-fugitive', config = function ()
        vim.cmd[[
            nnoremap <silent><leader>gb :GBrowse<cr>
            nnoremap <silent><leader>gc :Git mergetool<cr>
            nnoremap <silent><leader>d :Gvdiff!<cr>
            nnoremap <silent><leader>gd :Gvdiff!<cr>
            nnoremap <silent><leader>gh :diffget //2<cr>:diffupdate<cr>
            nnoremap <silent><leader>gl :diffget //3<cr>:diffupdate<cr>
        ]]
    end}
    use 'tpope/vim-rhubarb'
    use {'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' }, config = function ()
        require('gitsigns').setup {
            signs = {
                add          = { hl = 'GitSignsAdd', text = '│', numhl = 'GitSignsAddNr', linehl = 'GitSignsAddLn' },
                change       = { hl = 'GitSignsChange', text = '│', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
                delete       = { hl = 'GitSignsDelete', text = '│', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
                topdelete    = { hl = 'GitSignsDelete', text = '│', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
                changedelete = { hl = 'GitSignsChange', text = '│', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
            },
            keymaps = {
                buffer = false,
                ['n <leader>gn'] = '<cmd>lua require\"gitsigns.actions\".next_hunk()<CR>',
                ['n <leader>gp'] = '<cmd>lua require\"gitsigns.actions\".prev_hunk()<CR>',
                ['n <leader>gr'] = '<cmd>lua require\"gitsigns.actions\".reset_hunk()<CR>',
            },
            current_line_blame = true,
        }
    end}

    use {'SirVer/ultisnips', 'quangnguyen30192/cmp-nvim-ultisnips', config = function ()
        vim.cmd[[
            nnoremap !ru :UltiSnipsEdit!<cr>
            let g:UltiSnipsJumpForwardTrigger="<c-j>"
            let g:UltiSnipsJumpBackwardTrigger="<c-k>"
        ]]
        require("cmp_nvim_ultisnips").setup { filetype_source = "ultisnips_default" }
    end}
    use {'embear/vim-localvimrc', config = function ()
        vim.cmd[[
            " Vim localvimrc
            nnoremap !rV :e .vim/local.vim<cr>
            let g:localvimrc_name = [".vim/local.vim"]

            let g:localvimrc_file_directory_only = 0

            " Disable sandbox to enable running of autocmd
            " NOTE: do not remove ask, only accept if you know the content of vimrc
            let g:localvimrc_sandbox = 0
            let g:localvimrc_ask = 1

            " Store decision to source local vimrc
            let g:localvimrc_persistent = 2
        ]]
    end}

    -- Vim test
    use {'vim-test/vim-test', config = function ()
        vim.cmd[[
            let g:test#strategy = 'kitty'
            let g:test#preserve_screen = 1

            nnoremap <silent><leader>ctf :TestFile<cr>
            nnoremap <silent><leader>ctn :TestNearest<cr>
            nnoremap <silent><leader>ctt :TestSuite<cr>
        ]]
    end}

    -- Markdown
    use {'iamcco/markdown-preview.nvim', run= 'cd app && yarn install', config = function ()
        vim.cmd[[
            autocmd FileType markdown nnoremap <silent><buffer><leader>tm :MarkdownPreviewToggle<cr>
            let g:mkdp_auto_close = 0
        ]]
    end}
    use {'amiorin/vim-fenced-code-blocks', config = function ()
        vim.cmd[[
            augroup fenced_code_block
                autocmd!
                autocmd FileType markdown nnoremap <buffer> <silent> <leader>cgf :E<cr>
            augroup END
        ]]
    end}

    -- Parentheses formatting
    use {'andymass/vim-matchup', config = function ()
        vim.cmd[[let g:matchup_matchparen_offscreen = {'method': ''}]]
    end}
    use {'windwp/nvim-autopairs', config= function ()
        local cmp = require 'cmp'
        local cmp_autopairs = require('nvim-autopairs.completion.cmp')
        require('nvim-autopairs').setup {}
        cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done({ map_char = { tex = '' } }))
    end}
    use {'windwp/nvim-ts-autotag', requires = "nvim-treesitter/nvim-treesitter", config = function ()
        require('nvim-ts-autotag').setup()
    end}

    -- Show highlight when there is trailing whitespace
    use {'bronson/vim-trailing-whitespace', config = function ()
        vim.cmd[[
            let g:extra_whitespace_ignored_filetypes = ['Mundo','MundoDiff']
        ]]
    end}

    -- For Commenting
    use 'tpope/vim-commentary'

    -- Underline all other instance of word under cursor
    use 'itchyny/vim-cursorword'
    use {'whatyouhide/vim-lengthmatters', config = function ()
        vim.cmd[[
            nnoremap <leader>to :LengthmattersToggle<cr>
            let g:lengthmatters_excluded = ['Mundo', 'MundoDiff', 'NvimTree', 'help', 'qf', 'WhichKey', 'min', 'markdown']
            call lengthmatters#highlight('gui=undercurl')
        ]]
    end}
    use 'tpope/vim-surround'
    use {'qpkorr/vim-bufkill', config = function ()
        vim.cmd[[
            let g:BufKillCreateMappings = 0
            noremap <silent><leader>bd :<c-u>BW!<cr>
            noremap <silent><leader>ba :<c-u>bufdo BW<cr>
        ]]
    end}

    -- Fuzzy finder for files, grep and more
    use {'junegunn/fzf.vim', config = function ()
        vim.cmd[[
            let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }
            let g:fzf_preview_window = ['right:50%', 'ctrl-/']
            let g:default_layout = {'options': ['--layout=reverse', '--preview-window=']}
            let g:default_layout_with_preview = {'options': ['--layout=reverse']}

            " Find files
            nnoremap <silent><leader>sf :call fzf#vim#files('', fzf#vim#with_preview(g:default_layout_with_preview))<cr>

            " Ag
            nnoremap <silent><leader>sa :exec "call fzf#vim#grep('rg --line-number --no-heading --color=always -- '.shellescape('".input("grep > ")."'), 0, fzf#vim#with_preview(g:default_layout_with_preview),0)"<cr>
            nnoremap <silent><leader>su :call fzf#vim#grep('rg --fixed-strings --line-number --no-heading --color=always -- '.shellescape(expand('<cword>')), 0, fzf#vim#with_preview(g:default_layout_with_preview))<cr>

            " Buffer
            nnoremap <silent><leader>bb :call fzf#vim#buffers('', fzf#vim#with_preview(g:default_layout_with_preview))<cr>

            " Show all commands
            nnoremap <silent><leader>? :call fzf#vim#commands(g:default_layout)<cr>
        ]]
    end, requires = { 'junegunn/fzf', run = 'fzf#install()'}}

    -- Code Intellisense
    use {'williamboman/nvim-lsp-installer',
    config= function ()
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
        -- Loop through the servers listed above and set them up. If a server is
        -- not already installed, install it.
        for _, server_name in pairs(servers) do
            local server_available, server = lsp_installer_servers.get_server(server_name)
            if server_available then
                server:on_ready(function()
                    local keymap_opts = { noremap = true, silent = true }
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
                        server_opts.on_attach = function(client, bufnr)
                            client.resolved_capabilities.document_formatting = false -- Prefer eslint
                            common_on_attach(client, bufnr)
                        end
                    elseif server.name == "eslint" then
                        server_opts.on_attach = function(client, bufnr)
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
                    elseif server.name == "sumneko_lua" then
                        local luadev = require("lua-dev").setup()
                        luadev.settings.Lua.diagnostics = { globals = { "vim" } }
                        server_opts.settings = luadev.settings
                    end
                    server:setup(server_opts)
                end)
                if not server:is_installed() then
                    -- Queue the server to be installed.
                    server:install()
                end
            end
        end
    end,
    requires = {
        'neovim/nvim-lspconfig',
        'folke/lua-dev.nvim',
        'b0o/schemastore.nvim'
    }}
    use {'stevearc/aerial.nvim', config = function ()
        local kind_icons = require("kind-icons")
        local js_kind = { "Class", "Constructor", "Enum", "Function", "Interface", "Module", "Method", "Struct", "Constant", "Variable", "Field" }
        local data_kind = { "Module", "Number", "Array", "Boolean", "String" }
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
    end}
    use {'folke/trouble.nvim', config = function ()
        require("trouble").setup {}
    end}

    use {'hrsh7th/nvim-cmp',
    config = function ()
        local cmp = require 'cmp'
        local compare = require 'cmp.config.compare'
        local kind_icons = require("kind-icons")

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
    end,
    requires = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-nvim-lsp-signature-help",
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-buffer',
        'quangnguyen30192/cmp-nvim-ultisnips',
        {"tzachar/cmp-tabnine", run = './install.sh', config= function ()
            local tabnine = require('cmp_tabnine.config')
            tabnine:setup({
              max_num_results = 2;
            })
        end}}}

    -- Colorscheme
    use {'chriskempson/base16-vim', config = function ()
        vim.cmd[[
            colorscheme base16-tomorrow-night
            set termguicolors
            let base16colorspace=256

            " Highlight Formatting ------------------------------------------------- {{{
            exec "hi NonText guifg=#".g:base16_gui02." guibg=None"

            " Swap base16 tomorrow IncSearch and Search
            exec "hi Search guibg=#".g:base16_gui09
            exec "hi IncSearch guibg=#".g:base16_gui0A

            "" Syntax
            exec "hi Comment gui=italic guifg=#".g:base16_gui03." guibg=None"

            "" Other Visuals
            hi MatchParen gui=bold,italic guibg=NONE guifg=NONE
            exec "hi StatusLine gui=NONE guifg=#".g:base16_gui02." guibg=None"
            exec "hi StatusLineNC gui=NONE guifg=#".g:base16_gui02." guibg=None"
            exec "hi VertSplit gui=NONE guifg=#".g:base16_gui02." guibg=None"
            exec "hi DiffAdd gui=NONE guifg=NONE guibg=NONE"
            exec "hi DiffDelete gui=NONE guifg=#".g:base16_gui01." guibg=#".g:base16_gui01
            exec "hi DiffText gui=undercurl guifg=#".g:base16_gui00." guibg=#".g:base16_gui0D

            exec "hi DiagnosticError gui=NONE guifg=#".g:base16_gui08." guibg=None"
            exec "hi DiagnosticUnderlineError gui=undercurl guisp=#".g:base16_gui08
            exec "hi DiagnosticWarn gui=NONE guifg=#".g:base16_gui0A." guibg=None"
            exec "hi DiagnosticUnderlineWarn gui=undercurl guisp=#".g:base16_gui0A
            exec "hi DiagnosticInfo gui=NONE guifg=#".g:base16_gui0B." guibg=None"
            exec "hi DiagnosticUnderlineInfo gui=undercurl guisp=#".g:base16_gui0B

            exec "hi DiagnosticHint gui=NONE guifg=#".g:base16_gui0D." guibg=None"
            exec "hi DiagnosticUnderlineHint gui=undercurl guisp=#".g:base16_gui0D
            exec "hi DiagnosticVirtualText gui=undercurl,bold guifg=#".g:base16_gui02." guibg=None"
            hi! link DiagnosticVirtualTextError DiagnosticVirtualText
            hi! link DiagnosticVirtualTextWarn DiagnosticVirtualText
            hi! link DiagnosticVirtualTextInfo DiagnosticVirtualText
            hi! link DiagnosticVirtualTextHint DiagnosticVirtualText

            "" Gutter
            hi LineNr guibg=NONE
            hi CursorLineNr guibg=NONE
            hi SignColumn guibg=NONE
            hi FoldColumn guibg=NONE
            " }}}

            "" Cmp
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
            ]]
        end }

    -- Scrollbar
    use {'dstein64/nvim-scrollview', config = function ()
        vim.cmd[[
            let g:scrollview_winblend = 30
            let g:scrollview_column = 1
            let g:scrollview_excluded_filetypes = ['NvimTree','WhichKey']
        ]]
    end}

    -- Multi cursor edit
    use {'mg979/vim-visual-multi', config= function ()
        vim.cmd[[
            let g:VM_default_mappings = 0
            let g:VM_mouse_mappings = 1
            let g:VM_maps = {}
            let g:VM_maps["Find Under"] = '\'
            let g:VM_maps['Find Subword Under'] = '\'
            let g:VM_maps['Select All'] = 'g\'
        ]]
    end}

    -- TreeSitter: Better highlight and autoindent information
    use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate', config = function ()
        require('nvim-treesitter-config')
    end}
    use {'nvim-treesitter/playground', requires = "nvim-treesitter/nvim-treesitter"}
    use {'JoosepAlviste/nvim-ts-context-commentstring', requires = "nvim-treesitter/nvim-treesitter"}

    -- Allow autodetect of file indent
    use {'tpope/vim-sleuth', config = function ()
        vim.cmd[[
            augroup sleuth
                autocmd!
                autocmd FileType,BufWinEnter snippets let b:sleuth_automatic = 0
            augroup END
        ]]
    end}

    -- Rails Development
    use {'tpope/vim-rails', config = function ()
        vim.cmd[[
            augroup vim_rails
                autocmd!
                " <leader>cga does a collection of useful goto
                autocmd FileType ruby nnoremap <buffer> <silent> <leader>cga :Econtroller<cr>:Emodel<cr>:Ehelper<cr>
                " <leader>cgt goes to related test
                autocmd FileType ruby nnoremap <buffer> <silent> <leader>cgt :A<cr>
                autocmd FileType ruby nnoremap <buffer> <silent> <leader>cgv :Eview<cr>
                autocmd FileType ruby nnoremap <buffer> <silent> <leader>cgc :Econtroller<cr>
                autocmd FileType ruby nnoremap <buffer> <silent> <leader>cgm :Emodel<cr>
                autocmd FileType ruby nnoremap <buffer> <silent> <leader>cgh :Ehelper<cr>
                autocmd FileType ruby nnoremap <buffer> <silent> <leader>cgds :Eschema<cr>
                autocmd FileType ruby nnoremap <buffer> <silent> <leader>cgdm :Emigration<cr>
            augroup END
        ]]
    end}

    -- For language that are not yet covered by treesitter
    use 'purescript-contrib/purescript-vim'

    -- Additional Syntax Support
    use 'aklt/plantuml-syntax'
end)



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

vim.cmd[[
runtime src/after-plugin.vim
]]
