local personal_project = '~/workspace-bootstrap/git/chunleng/'
require("common-utils").setup()
require("common-theme").setup()

require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    use {
        'kyazdani42/nvim-tree.lua',
        config = function() require('config.nvim-tree').setup() end,
        requires = 'kyazdani42/nvim-web-devicons',
        after = "nvim-treesitter"
    }

    -- Cursorline Related
    use {
        'glepnir/galaxyline.nvim',
        requires = {'SmiteshP/nvim-navic'},
        config = function() require("config.galaxyline").setup() end,
        after = {'mason.nvim'}
    }

    -- https://github.com/akinsho/bufferline.nvim
    -- https://github.com/famiu/bufdelete.nvim
    use {
        'akinsho/bufferline.nvim',
        requires = {'famiu/bufdelete.nvim'},
        config = function() require('config.bufferline').setup() end
    }

    -- Allow to view edit history
    use {
        'simnalamburt/vim-mundo',
        config = function() require("config.mundo").setup() end
    }

    use {
        'AndrewRadev/linediff.vim',
        config = function() require("config.linediff").setup() end
    }

    use {
        'tpope/vim-fugitive',
        config = function() require("config.fugitive").setup() end,
        requires = 'tpope/vim-rhubarb' -- for GBrowse
    }

    use {
        'lewis6991/gitsigns.nvim',
        config = function() require("config.gitsigns").setup() end,
        requires = 'nvim-lua/plenary.nvim'
    }

    use {
        'embear/vim-localvimrc',
        config = function() require("config.localvimrc").setup() end
    }

    -- https://github.com/nvim-neotest/neotest
    -- https://github.com/nvim-lua/plenary.nvim
    -- https://github.com/antoinemadec/FixCursorHold.nvim
    -- https://github.com/nvim-treesitter/nvim-treesitter
    -- https://github.com/nvim-neotest/neotest-python
    use {
        'nvim-neotest/neotest',
        requires = {
            'nvim-lua/plenary.nvim', 'nvim-treesitter/nvim-treesitter',
            'antoinemadec/FixCursorHold.nvim', 'nvim-neotest/neotest-python'
        },
        config = function()
            local neotest = require('neotest')
            -- https://github.com/nvim-neotest/neotest#supported-runners
            neotest.setup({
                adapters = {},
                icons = {
                    child_indent = ' ',
                    child_prefix = ' ',
                    collapsed = '▸',
                    expanded = '▾',
                    final_child_indent = ' ',
                    final_child_prefix = ' ',
                    non_collapsible = ' ',
                    failed = '',
                    passed = '',
                    unknown = '',
                    skipped = '',
                    running = ''
                },
                output_panel = {open = 'topleft vsplit | vertical resize 20'},
                quickfix = {enabled = false},
                summary = {
                    animated = false,
                    open = 'topleft vsplit | vertical resize 30',
                    mappings = {
                        attach = {},
                        clear_marked = {},
                        clear_target = {},
                        debug = 'd',
                        debug_marked = {},
                        expand = 'l',
                        expand_all = {},
                        jumpto = '<cr>',
                        mark = {},
                        next_failed = "J",
                        output = {},
                        prev_failed = "K",
                        run = "r",
                        run_marked = {},
                        short = 'o',
                        stop = {},
                        target = {}
                    }
                }
            })

            local utils = require('common-utils')
            utils.keymap('n', '<c-s-t>', function()
                neotest.summary.toggle()
            end)
            utils.keymap('n', '<c-t>', function() neotest.run.run() end)
            utils.keymap('n', '<leader>ct',
                         function()
                neotest.run.run(vim.fn.expand('%'))
            end)

            local group_name = 'lNeotestSummary'
            vim.api.nvim_create_augroup(group_name, {clear = true})
            vim.api.nvim_create_autocmd('FileType', {
                pattern = 'neotest-summary',
                callback = function(opt)
                    utils.buf_keymap(opt.buf, 'n', 'q',
                                     function()
                        neotest.summary.close()
                    end)
                end,
                group = group_name
            })

            local theme = require('common-theme')
            theme.set_hl('NeotestAdapterName', {bold = true, fg = 4})
            theme.set_hl('NeotestExpandMarker', {link = 'Comment'})
            theme.set_hl('NeotestDir', {fg = theme.blender.fg_darker_3})
            theme.set_hl('NeotestFile', {fg = 12})
            theme.set_hl('NeotestFocused', {underline = true})
            theme.set_hl('NeotestPassed', {fg = theme.blender.passed})
            theme.set_hl('NeotestFailed', {fg = theme.blender.failed})
            theme.set_hl('NeotestUnknown', {fg = theme.blender.bg_lighter_3})
            theme.set_hl('NeotestSkipped', {fg = 14})
            theme.set_hl('NeotestRunning', {fg = 12})
            theme.set_hl('NeotestTest', {link = 'Normal'})
        end
    }

    -- Markdown
    use {
        'iamcco/markdown-preview.nvim',
        run = 'cd app && yarn install',
        config = function() require("config.markdown-preview").setup() end
    }
    use {
        'amiorin/vim-fenced-code-blocks',
        config = function() require("config.fenced-code-blocks").setup() end
    }

    -- Parentheses formatting
    use {
        'andymass/vim-matchup',
        config = function() require("config.matchup").setup() end
    }
    use {
        'windwp/nvim-autopairs',
        config = function() require("config.autopairs").setup() end,
        after = {"nvim-treesitter"}
    }
    use {"RRethy/nvim-treesitter-endwise", after = "nvim-treesitter"}

    use {
        'windwp/nvim-ts-autotag',
        config = function() require('nvim-ts-autotag').setup() end,
        after = "nvim-treesitter"
    }

    -- https://github.com/numToStr/Comment.nvim
    use {
        'numToStr/Comment.nvim',
        config = function() require('config.comment').setup() end
    }

    use {
        'bronson/vim-trailing-whitespace',
        config = function() require("config.trailing-whitespace").setup() end
    }

    use {
        "RRethy/vim-illuminate",
        config = function() require("config.illuminate").setup() end
    }

    use 'tpope/vim-surround'
    -- Fuzzy finder for files, grep and more
    use {
        'ibhagwan/fzf-lua',
        config = function() require("config.fzf").setup() end,
        requires = {'kyazdani42/nvim-web-devicons', 'williamboman/mason.nvim'},
        after = 'nvim-dap-ui'
    }

    -- Code Intellisense
    -- https://github.com/mfussenegger/nvim-dap
    -- https://github.com/jayp0521/mason-nvim-dap.nvim
    use {
        'williamboman/mason.nvim',
        config = function() require("config.mason").setup() end,
        requires = {
            'williamboman/mason-lspconfig', 'neovim/nvim-lspconfig',
            'folke/neodev.nvim', 'b0o/schemastore.nvim', 'ibhagwan/fzf-lua',
            'jayp0521/mason-nvim-dap.nvim', 'mfussenegger/nvim-dap',
            'rcarriga/nvim-dap-ui', 'ofirgall/goto-breakpoints.nvim',
            personal_project .. 'nvim-dap-kitty-launcher'
        },
        after = {"aerial.nvim"}
    }

    use {
        'stevearc/aerial.nvim',
        config = function() require("config.aerial-nvim").setup() end
    }

    use {"tpope/vim-dadbod"}
    use {
        "kristijanhusak/vim-dadbod-ui",
        setup = function() require("config.dadbod-ui").beforeSetup() end,
        config = function() require("config.dadbod-ui").setup() end,
        after = "vim-dadbod"
    }

    -- https://github.com/roobert/tailwindcss-colorizer-cmp.nvim/
    use {
        'hrsh7th/nvim-cmp',
        requires = {
            'hrsh7th/cmp-buffer', 'hrsh7th/cmp-path', 'hrsh7th/cmp-nvim-lsp',
            'kristijanhusak/vim-dadbod-completion',
            'roobert/tailwindcss-colorizer-cmp.nvim'
        },
        config = function() require("config.nvim-cmp").setup() end,
        after = {'mason.nvim', 'vim-dadbod'}
    }

    -- https://github.com/danymat/neogen
    use {
        'chunleng/nvim-null',
        as = 'snippets',
        requires = {'L3MON4D3/LuaSnip', 'danymat/neogen'},
        config = function() require('config.snippets').setup() end
    }
    -- https://github.com/saadparwaiz1/cmp_luasnip
    -- https://github.com/L3MON4D3/LuaSnip
    use {
        'saadparwaiz1/cmp_luasnip',
        requires = 'L3MON4D3/LuaSnip',
        after = 'nvim-cmp'
    }

    use {
        'chunleng/nvim-null',
        as = 'resolve_cr',
        config = function()
            local utils = require('common-utils')
            local ls = require('luasnip')

            utils.keymap({'i', 's'}, '<cr>', function()
                if ls.jumpable() then
                    ls.jump(1)
                else
                    local is_end_of_line =
                        #vim.api.nvim_get_current_line() ==
                            vim.api.nvim_win_get_cursor(0)[2]
                    if is_end_of_line and vim.o.filetype == 'markdown' then
                        vim.cmd('InsertNewBullet')
                    else
                        vim.fn.feedkeys(
                            require('nvim-autopairs').autopairs_cr(), 'n')
                    end
                end
            end)
        end,
        after = {'nvim-autopairs', 'LuaSnip', 'bullets.vim'}
    }

    use {
        'chunleng/nvim-null',
        as = 'resolve_s_cr',
        config = function()
            local utils = require('common-utils')
            local ls = require('luasnip')

            utils.keymap({'i', 's'}, '<s-cr>', function()
                if ls.jumpable() then
                    ls.jump(-1)
                else
                    -- Enter without cursor going to the next line
                    vim.api.nvim_eval(
                        [[feedkeys("\<enter>\<c-o>k\<c-o>Aa\<c-o>==\<c-o>A\<bs>", "n")]]) -- `a<c-o>==<c-o>A<bs>` is to make auto indent work
                end
            end)
        end,
        after = 'LuaSnip'
    }

    use {
        'chunleng/nvim-null',
        as = 'resolve_rc_menu',
        config = function()
            local utils = require('common-utils')
            utils.keymap('n', '<c-s-r>', function()
                vim.ui.select({
                    'Vim RC', 'Vim Local RC', 'Direnvrc', 'LuaSnip', 'Zsh',
                    'Hammerspoon', 'Kitty'
                }, {}, function(choice)
                    if choice == 'Vim RC' then
                        vim.cmd('edit ~/.config/nvim/init.lua')
                    elseif choice == 'Vim Local RC' then
                        vim.cmd([[
                            silent !mkdir -p .vim
                            edit .vim/local.lua
                        ]])
                    elseif choice == 'Direnvrc' then
                        vim.cmd('edit .envrc')
                    elseif choice == 'LuaSnip' then
                        require('luasnip.loaders').edit_snippet_files()
                    elseif choice == 'Zsh' then
                        vim.cmd('edit ~/.zshrc')
                    elseif choice == 'Hammerspoon' then
                        vim.cmd('edit ~/.hammerspoon/init.lua')
                    elseif choice == 'Kitty' then
                        vim.cmd('edit ~/.config/kitty/kitty.conf')
                    end
                end)
            end)
        end,
        after = {'LuaSnip', 'vim-localvimrc'}
    }

    -- Scrollbar
    use {
        'petertriho/nvim-scrollbar',
        config = function() require("config.nvim-scrollbar").setup() end
    }

    -- TreeSitter: Better highlight and autoindent information
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = function() require('config.treesitter').setup() end
    }
    use {
        'nvim-treesitter/playground',
        opt = true, -- load by using `packadd playground`
        requires = "nvim-treesitter/nvim-treesitter"
    }
    use {
        'JoosepAlviste/nvim-ts-context-commentstring',
        requires = "nvim-treesitter/nvim-treesitter"
    }

    -- https://github.com/tpope/vim-sleuth
    -- https://github.com/Yggdroot/indentLine/
    use {
        'chunleng/nvim-null',
        as = 'indent_config',
        requires = {'tpope/vim-sleuth', 'Yggdroot/indentLine'},
        config = function() require('config.indent').setup() end
    }

    -- Rails Development
    use {
        'tpope/vim-rails',
        config = function() require("config.rails").setup() end
    }

    -- For language that are not yet covered by treesitter
    use 'purescript-contrib/purescript-vim'

    -- Additional Syntax Support
    use 'aklt/plantuml-syntax'

    use {
        'NvChad/nvim-colorizer.lua',
        config = function() require("config.colorizer").setup() end
    }

    use {
        'stevearc/dressing.nvim',
        config = function() require("config.dressing").setup() end
    }

    use {
        "dkarter/bullets.vim",
        config = function() require("config.bullets").setup() end
    }

    use {
        "b0o/incline.nvim",
        config = function() require("config.incline").setup() end
    }

    use {
        "mattn/emmet-vim",
        config = function() require("config.emmet").setup() end
    }

    -- https://github.com/nvim-treesitter/nvim-treesitter-context
    use {
        "nvim-treesitter/nvim-treesitter-context",
        config = function() require('config.treesitter-context').setup() end
    }

    -- https://github.com/aduros/ai.vim
    use {'aduros/ai.vim', config = function() require('config.ai').setup() end}

    -- https://github.com/tpope/vim-projectionist
    use {
        'tpope/vim-projectionist',
        config = function() require('config.projectionist').setup() end
    }

    use {
        'chunleng/nvim-null',
        as = 'stop_conceal',
        config = function()
            -- Using this because there are some problems with control over conceals
            -- https://github.com/nvim-treesitter/nvim-treesitter/issues/2825

            for _, lang in ipairs({'json', 'markdown', 'markdown_inline'}) do
                local queries = {}
                for _, file in ipairs(require('vim.treesitter.query').get_files(
                                          lang, 'highlights')) do
                    for _, line in ipairs(vim.fn.readfile(file)) do
                        local line_sub = line:gsub([[%(#set! conceal ""%)]], '')
                        table.insert(queries, line_sub)
                    end
                end
                require('vim.treesitter.query').set(lang, 'highlights',
                                                    table.concat(queries, '\n'))
            end
        end,
        after = {'nvim-treesitter'}
    }

    use {
        'chunleng/nvim-null',
        as = 'quick_replace',
        config = function()
            local utils = require('common-utils')

            -- Easy replace with selection
            utils.keymap('x', '<c-r>', function()
                local separator = ''
                local left_key = vim.api.nvim_replace_termcodes('<left>', true,
                                                                false, true)
                -- TODO replace fzf-lua get_visual_selection function with
                -- https://github.com/neovim/neovim/issues/16843
                local feedkeys = (':%%s%s\\(%s\\)%s%sg%s%s'):format(separator,
                                                                     require(
                                                                         'fzf-lua.utils').get_visual_selection(),
                                                                     separator,
                                                                     separator,
                                                                     left_key,
                                                                     left_key)
                vim.api.nvim_feedkeys(feedkeys, 'n', false)
            end)

        end,
        after = {'fzf-lua'}
    }

    use {
        'chunleng/nvim-null',
        as = 'resolve_c_cr',
        config = function()
            local ls = require('luasnip')
            local utils = require('common-utils')
            utils.keymap('i', '<c-enter>', function()
                if ls.choice_active() then
                    ls.change_choice(1)
                else
                    vim.api.nvim_eval(
                        [[feedkeys("\<c-r>=emmet#util#closePopup()\<cr>\<c-r>=emmet#expandAbbr(0,\"\")\<cr>", "n")]])
                end
            end)
            utils.keymap('x', '<c-enter>', function()
                if ls.choice_active() then
                    ls.change_choice(1)
                else
                    vim.fn.call('emmet#expandAbbr', {2, ''})
                end
            end)
            utils.keymap('s', '<c-enter>', function()
                if ls.choice_active() then ls.change_choice(1) end
            end)
        end,
        after = {'emmet-vim', 'LuaSnip'}
    }

    use {
        'Wansmer/treesj',
        requires = {'nvim-treesitter'},
        config = function() require('config.treesj').setup() end
    }

end)

