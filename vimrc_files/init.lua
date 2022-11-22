require("common-utils").setup()
require("common-theme").setup()
require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    use {
        'folke/which-key.nvim',
        config = function() require("config.which-key").setup() end
    }
    use {
        'kyazdani42/nvim-tree.lua',
        config = function() require('config.nvim-tree').setup() end,
        requires = 'kyazdani42/nvim-web-devicons',
        after = "nvim-treesitter"
    }

    -- Beautify
    use {
        'glepnir/galaxyline.nvim',
        config = function() require("config.galaxyline").setup() end,
        after = {"nvim-gps"}
    }
    use {
        'romgrk/barbar.nvim',
        config = function() require('config.barbar').setup() end,
        requires = 'kyazdani42/nvim-web-devicons'
    }
    use {
        'SmiteshP/nvim-gps',
        config = function() require("nvim-gps").setup() end,
        requires = "nvim-treesitter/nvim-treesitter"
    }

    -- Allow to view edit history
    use {
        'simnalamburt/vim-mundo',
        config = function() require("config.mundo").setup() end
    }
    use {
        -- TODO fix pretty-mode
        'chunleng/indent-guides.nvim',
        config = function() require("config.indent-guides").setup() end
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

    -- Vim test
    use {
        'vim-test/vim-test',
        config = function() require("config.vim-test").setup() end
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
        requires = "tpope/vim-commentary", -- for commenting
        after = "nvim-treesitter"
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
        requires = 'kyazdani42/nvim-web-devicons'
    }

    -- Code Intellisense
    use {
        'williamboman/mason.nvim',
        config = function() require("config.mason").setup() end,
        requires = {
            'williamboman/mason-lspconfig', 'neovim/nvim-lspconfig',
            'folke/neodev.nvim', 'b0o/schemastore.nvim', 'ibhagwan/fzf-lua'
        },
        after = {"fzf-lua", "aerial.nvim"}
    }

    use {
        'stevearc/aerial.nvim',
        config = function() require("config.aerial-nvim").setup() end,
        commit = "4b42ddbd453caec3b12541af80e498a02d47cf20" -- Lock because this plugin tends to break easily
    }

    use {"tpope/vim-dadbod"}
    use {
        "kristijanhusak/vim-dadbod-ui",
        setup = function() require("config.dadbod-ui").beforeSetup() end,
        config = function() require("config.dadbod-ui").setup() end,
        after = "vim-dadbod"
    }
    use {
        'hrsh7th/nvim-cmp',
        config = function() require("config.nvim-cmp").setup() end
    }
    use {'hrsh7th/cmp-nvim-lsp', after = {"nvim-cmp", "mason.nvim"}}
    use {'hrsh7th/cmp-buffer', after = "nvim-cmp"}
    use {'hrsh7th/cmp-path', after = "nvim-cmp"}
    use {
        "kristijanhusak/vim-dadbod-completion",
        after = {"nvim-cmp", "vim-dadbod"}
    }
    use {
        'quangnguyen30192/cmp-nvim-ultisnips',
        run = "./install.sh",
        config = function() require("config.cmp-nvim-ultisnips").setup() end,
        after = {"ultisnips", "nvim-cmp"}
    }
    use {
        'SirVer/ultisnips',
        config = function() require("config.ultisnips").setup() end
    }

    -- Scrollbar
    use {
        'petertriho/nvim-scrollbar',
        config = function() require("config.nvim-scrollbar").setup() end
    }

    -- Multi cursor edit
    use {
        'mg979/vim-visual-multi',
        config = function() require("config.visual-multi").setup() end
    }

    -- TreeSitter: Better highlight and autoindent information
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = function() require('config.treesitter').setup() end
    }
    use {
        'nvim-treesitter/playground',
        opt = true, -- load by using `packeradd playground`
        requires = "nvim-treesitter/nvim-treesitter"
    }
    use {
        'JoosepAlviste/nvim-ts-context-commentstring',
        requires = "nvim-treesitter/nvim-treesitter"
    }

    -- Allow autodetect of file indent
    use {
        'tpope/vim-sleuth',
        config = function() require("config.sleuth").setup() end
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

    -- https://github.com/dkarter/bullets.vim/issues/57
    -- https://github.com/dkarter/bullets.vim/pull/93
    -- Seems like creator is not dedicated to fixing this issue, PR has been requested over 1 year and not closed
    use {
        "chunleng/bullets.vim",
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
end)
