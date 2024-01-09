local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git", "clone", "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git", "--branch=stable", -- latest stable release
        lazypath
    })

end
vim.opt.rtp:prepend(lazypath)

local personal_project = '~/workspace-bootstrap/git/chunleng/'

require("lazy").setup({
    {import = 'common', priority = 99}, {
        -- https://github.com/nvim-tree/nvim-tree.lua
        -- https://github.com/kyazdani42/nvim-web-devicons
        -- https://github.com/nvim-treesitter/nvim-treesitter
        'kyazdani42/nvim-tree.lua',
        dependencies = {
            'kyazdani42/nvim-web-devicons', 'nvim-treesitter/nvim-treesitter'
        },
        config = function() require('config.nvim-tree').setup() end
    }, {
        -- https://github.com/glepnir/galaxyline.nvim
        -- https://github.com/SmiteshP/nvim-navic
        -- https://github.com/williamboman/mason.nvim
        'glepnir/galaxyline.nvim',
        dependencies = {'SmiteshP/nvim-navic', 'williamboman/mason.nvim'},
        config = function() require("config.cursorline").setup() end
    }, {
        -- https://github.com/akinsho/bufferline.nvim
        -- https://github.com/famiu/bufdelete.nvim
        'akinsho/bufferline.nvim',
        dependencies = {'famiu/bufdelete.nvim'},
        config = function() require('config.bufferline').setup() end
    }, {
        -- https://github.com/simnalamburt/vim-mundo
        'simnalamburt/vim-mundo',
        config = function() require("config.mundo").setup() end
    }, {
        -- https://github.com/AndrewRadev/linediff.vim
        'AndrewRadev/linediff.vim',
        config = function() require("config.linediff").setup() end
    }, {
        -- https://github.com/tpope/vim-fugitive
        -- https://github.com/tpope/vim-rhubarb
        'tpope/vim-fugitive',
        dependencies = {
            'tpope/vim-rhubarb' -- for GBrowse
        },
        config = function() require("config.fugitive").setup() end
    }, {
        -- https://github.com/lewis6991/gitsigns.nvim
        -- https://github.com/nvim-lua/plenary.nvim
        'lewis6991/gitsigns.nvim',
        dependencies = {'nvim-lua/plenary.nvim'},
        config = function() require("config.gitsigns").setup() end
    }, {
        -- https://github.com/embear/vim-localvimrc
        'embear/vim-localvimrc',
        init = function() require("config.localvimrc").setup() end
    }, {
        -- https://github.com/nvim-neotest/neotest
        -- https://github.com/nvim-lua/plenary.nvim
        -- https://github.com/nvim-treesitter/nvim-treesitter
        -- https://github.com/nvim-neotest/neotest-python
        -- https://github.com/nvim-neotest/neotest-jest
        'nvim-neotest/neotest',
        dependencies = {
            'nvim-lua/plenary.nvim', 'nvim-treesitter/nvim-treesitter',
            -- https://github.com/nvim-neotest/neotest#supported-runners
            'nvim-neotest/neotest-python', 'nvim-neotest/neotest-jest'
        },
        config = function() require('config.test').setup() end
    }, {
        -- https://github.com/iamcco/markdown-preview.nvim
        'iamcco/markdown-preview.nvim',
        build = function() vim.fn["mkdp#util#install"]() end,
        config = function() require("config.markdown-preview").setup() end,
        ft = {'markdown'}
    }, {
        -- https://github.com/amiorin/vim-fenced-code-blocks
        -- https://github.com/nvim-treesitter/nvim-treesitter
        'amiorin/vim-fenced-code-blocks',
        dependencies = {'nvim-treesitter/nvim-treesitter'},
        config = function() require("config.fenced-code-blocks").setup() end,
        ft = {'markdown'}
    }, {
        -- https://github.com/nvim-treesitter/nvim-treesitter
        'nvim-treesitter/nvim-treesitter',
        config = function() require('config.treesitter').setup() end
    }, {
        -- https://github.com/windwp/nvim-autopairs
        -- https://github.com/nvim-treesitter/nvim-treesitter
        'windwp/nvim-autopairs',
        dependencies = {'nvim-treesitter/nvim-treesitter'},
        config = function() require("config.autopairs").setup() end
    }, {
        -- https://github.com/RRethy/nvim-treesitter-endwise
        -- https://github.com/nvim-treesitter/nvim-treesitter
        "RRethy/nvim-treesitter-endwise",
        dependencies = {'nvim-treesitter/nvim-treesitter'}
    }, {
        -- https://github.com/windwp/nvim-ts-autotag
        -- https://github.com/nvim-treesitter/nvim-treesitter
        'windwp/nvim-ts-autotag',
        dependencies = {'nvim-treesitter/nvim-treesitter'},
        config = function() require('nvim-ts-autotag').setup() end
    }, {
        -- https://github.com/numToStr/Comment.nvim
        'numToStr/Comment.nvim',
        config = function() require('config.comment').setup() end
    }, {
        -- https://github.com/bronson/vim-trailing-whitespace
        'bronson/vim-trailing-whitespace',
        config = function() require("config.trailing-whitespace").setup() end
    }, {
        -- https://github.com/RRethy/vim-illuminate
        "RRethy/vim-illuminate",
        config = function() require("config.illuminate").setup() end
    }, {
        -- https://github.com/tpope/vim-surround
        "tpope/vim-surround"
    }, {
        -- https://github.com/ibhagwan/fzf-lua
        'ibhagwan/fzf-lua',
        dependencies = {'kyazdani42/nvim-web-devicons', 'lsp'},
        config = function() require("config.fzf").setup() end
    }, {
        -- https://github.com/williamboman/mason.nvim
        -- https://github.com/williamboman/mason-lspconfig
        -- https://github.com/neovim/nvim-lspconfig
        -- https://github.com/folke/neodev.nvim
        -- https://github.com/b0o/schemastore.nvim
        -- https://github.com/ibhagwan/fzf-lua
        -- https://github.com/jayp0521/mason-nvim-dap.nvim
        -- https://github.com/mfussenegger/nvim-dap
        -- https://github.com/rcarriga/nvim-dap-ui
        -- https://github.com/ofirgall/goto-breakpoints.nvim
        -- https://github.com/jose-elias-alvarez/null-ls.nvim
        -- https://github.com/barreiroleo/ltex_extra.nvim
        -- https://github.com/stevearc/aerial.nvim
        'williamboman/mason.nvim',
        name = 'lsp',
        dependencies = {
            'williamboman/mason-lspconfig', 'neovim/nvim-lspconfig',
            'folke/neodev.nvim', 'b0o/schemastore.nvim', 'ibhagwan/fzf-lua',
            'jayp0521/mason-nvim-dap.nvim', 'mfussenegger/nvim-dap',
            'rcarriga/nvim-dap-ui', 'ofirgall/goto-breakpoints.nvim',
            'jose-elias-alvarez/null-ls.nvim', 'barreiroleo/ltex_extra.nvim',
            'stevearc/aerial.nvim',
            {dir = personal_project .. 'nvim-dap-kitty-launcher'}
        },
        config = function() require("config.lsp").setup() end
    }, {
        -- https://github.com/stevearc/aerial.nvim
        'stevearc/aerial.nvim',
        config = function() require("config.aerial-nvim").setup() end
    }, {
        -- https://github.com/kristijanhusak/vim-dadbod-ui
        -- https://github.com/tpope/vim-dadbod
        "kristijanhusak/vim-dadbod-ui",
        dependencies = {'tpope/vim-dadbod'},
        init = function() require("config.dadbod-ui").beforeSetup() end,
        config = function() require("config.dadbod-ui").setup() end
    }, {
        -- https://github.com/hrsh7th/nvim-cmp
        -- https://github.com/hrsh7th/cmp-buffer
        -- https://github.com/hrsh7th/cmp-path
        -- https://github.com/hrsh7th/cmp-nvim-lsp
        -- https://github.com/kristijanhusak/vim-dadbod-completion
        -- https://github.com/roobert/tailwindcss-colorizer-cmp.nvim
        -- https://github.com/williamboman/mason.nvim
        -- https://github.com/tpope/vim-dadbod
        'hrsh7th/nvim-cmp',
        dependencies = {
            'hrsh7th/cmp-buffer', 'hrsh7th/cmp-path', 'hrsh7th/cmp-nvim-lsp',
            'kristijanhusak/vim-dadbod-completion',
            'roobert/tailwindcss-colorizer-cmp.nvim', 'williamboman/mason.nvim',
            'tpope/vim-dadbod'
        },
        config = function() require("config.nvim-cmp").setup() end
    }, {
        -- https://github.com/danymat/neogen
        -- https://github.com/L3MON4D3/LuaSnip
        'chunleng/nvim-null',
        name = 'snippets',
        dependencies = {'L3MON4D3/LuaSnip', 'danymat/neogen'},
        config = function() require('config.snippets').setup() end
    }, {
        -- https://github.com/saadparwaiz1/cmp_luasnip
        -- https://github.com/L3MON4D3/LuaSnip
        'saadparwaiz1/cmp_luasnip',
        dependencies = {'L3MON4D3/LuaSnip', 'hrsh7th/nvim-cmp'}
    }, {
        'chunleng/nvim-null',
        name = 'resolve_cr',
        config = function()
            local utils = require('common-utils')
            local ls = require('luasnip')

            utils.keymap({'i', 's'}, '<cr>', function()
                if ls.jumpable(1) then
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
        dependencies = {
            'windwp/nvim-autopairs', 'L3MON4D3/LuaSnip', 'dkarter/bullets.vim'
        }
    }, {
        'chunleng/nvim-null',
        name = 'resolve_s_cr',
        config = function()
            local utils = require('common-utils')
            local ls = require('luasnip')

            utils.keymap({'i', 's'}, '<s-cr>', function()
                if ls.jumpable(-1) then
                    ls.jump(-1)
                else
                    -- Enter without cursor going to the next line
                    vim.api.nvim_eval(
                        [[feedkeys("\<enter>\<c-o>k\<c-o>Aa\<c-o>==\<c-o>A\<bs>", "n")]]) -- `a<c-o>==<c-o>A<bs>` is to make auto indent work
                end
            end)
        end,
        dependencies = {'L3MON4D3/LuaSnip'}
    }, {
        -- https://github.com/L3MON4D3/LuaSnip
        -- https://github.com/embear/vim-localvimrc
        'chunleng/nvim-null',
        name = 'resolve_rc_menu',
        dependencies = {'L3MON4D3/LuaSnip', 'embear/vim-localvimrc'},
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
        end
    }, {
        -- https://github.com/petertriho/nvim-scrollbar
        'petertriho/nvim-scrollbar',
        config = function() require("config.nvim-scrollbar").setup() end
    }, {
        -- https://github.com/nvim-treesitter/playground
        -- https://github.com/nvim-treesitter/nvim-treesitter
        'nvim-treesitter/playground',
        cmd = "TSPlaygroundToggle",
        dependencies = {"nvim-treesitter/nvim-treesitter"}
    }, {
        -- https://github.com/JoosepAlviste/nvim-ts-context-commentstring
        -- https://github.com/nvim-treesitter/nvim-treesitter
        'JoosepAlviste/nvim-ts-context-commentstring',
        config = function() require('ts_context_commentstring').setup({}) end,
        dependencies = "nvim-treesitter/nvim-treesitter"
    }, {
        -- https://github.com/tpope/vim-sleuth
        -- https://github.com/Yggdroot/indentLine
        'Yggdroot/indentLine',
        dependencies = {'tpope/vim-sleuth'},
        config = function() require('config.indent').setup() end
    }, {
        -- https://github.com/tpope/vim-rails
        'tpope/vim-rails',
        config = function() require("config.rails").setup() end,
        ft = {'ruby'}
    }, {
        -- https://github.com/purescript-contrib/purescript-vim
        'purescript-contrib/purescript-vim',
        ft = {'purescript'}
    }, {
        -- https://github.com/aklt/plantuml-syntax
        'aklt/plantuml-syntax',
        ft = {'plantuml'}
    }, {
        -- https://github.com/NvChad/nvim-colorizer.lua
        'NvChad/nvim-colorizer.lua',
        config = function() require("config.colorizer").setup() end
    }, {
        -- https://github.com/stevearc/dressing.nvim
        'stevearc/dressing.nvim',
        config = function() require("config.dressing").setup() end
    }, {
        -- https://github.com/dkarter/bullets.vim
        "dkarter/bullets.vim",
        init = function() require("config.bullets").setup() end
    }, {
        -- https://github.com/b0o/incline.nvim
        "b0o/incline.nvim",
        config = function() require("config.incline").setup() end
    }, {
        -- https://github.com/mattn/emmet-vim
        "mattn/emmet-vim",
        config = function() require("config.emmet").setup() end
    }, {
        -- https://github.com/nvim-treesitter/nvim-treesitter-context
        "nvim-treesitter/nvim-treesitter-context",
        config = function() require('config.treesitter-context').setup() end
    }, {
        -- https://github.com/Robitx/gp.nvim
        'Robitx/gp.nvim',
        config = function() require('config.ai').setup() end
    }, {
        -- https://github.com/tpope/vim-projectionist
        'tpope/vim-projectionist',
        config = function() require('config.projectionist').setup() end
    }, {
        -- https://github.com/nvim-treesitter/nvim-treesitter
        'chunleng/nvim-null',
        name = 'stop_conceal',
        config = function()
            -- Using this because there are some problems with control over conceals
            -- https://github.com/nvim-treesitter/nvim-treesitter/issues/2825

            for _, lang in ipairs({
                'json', 'jsonc', 'markdown', 'markdown_inline'
            }) do
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
        dependencies = {'nvim-treesitter/nvim-treesitter'}
    }, {
        -- https://github.com/ibhagwan/fzf-lua
        'chunleng/nvim-null',
        name = 'quick_replace',
        dependencies = {'ibhagwan/fzf-lua'},
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

        end
    }, {
        'chunleng/nvim-null',
        name = 'resolve_c_cr',
        dependencies = {'mattn/emmet-vim', 'L3MON4D3/LuaSnip'},
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
        end
    }, {
        'mg979/vim-visual-multi',
        init = function()
            vim.g.VM_default_mappings = 0
            vim.g.VM_mouse_mappings = 0
            vim.g.VM_maps = {
                ["Find Under"] = "\\",
                ["Find Subword Under"] = "\\",
                ["Select All"] = "g\\"
            }
        end
    }, {
        'goerz/jupytext.vim',
        config = function()
            vim.g.jupytext_command =
                '_jupytext_vim() { zsh --login --interactive -c "asdf shell python 3.11.4 && jupytext $*" } && _jupytext_vim'
            vim.g.jupytext_fmt = 'py'
        end
    }, {
        -- A more sane gf
        -- https://github.com/nvim-tree/nvim-tree.lua
        'chunleng/nvim-null',
        name = 'resolve_gf',
        dependencies = {'kyazdani42/nvim-tree.lua'},
        config = function()
            local utils = require('common-utils')
            local tree_api = require("nvim-tree.api")

            -- Add on to existing feature
            utils.keymap("n", "gf", function()
                local path = vim.fn.expand('<cfile>')

                if not path:match("^/") then
                    path = vim.fn.expand('%:h') .. '/' .. path
                end

                if vim.fn.filereadable(path) == 1 then
                    vim.cmd(":e " .. path)
                elseif vim.fn.isdirectory(path) == 1 then
                    tree_api.tree.open()
                    tree_api.tree.find_file(path)
                else
                    local response = vim.fn.confirm('Create "' .. path .. '"?')
                    if response == 1 then
                        vim.cmd(":e " .. path)
                    end
                end
            end)
            -- utils.keymap("x", "gf", "<cmd>e %:h/<cword><cr>")
        end
    }, {
        -- https://github.com/mickael-menu/zk-nvim
        'mickael-menu/zk-nvim',
        config = function() require("zk").setup() end
    }
})
