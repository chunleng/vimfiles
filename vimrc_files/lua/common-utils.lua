local M = {}

local function configure_provider()
    if vim.fn.filereadable('/usr/local/bin/python3') == 1 then
        vim.g.python3_host_prog = '/usr/local/bin/python3'
    elseif vim.fn.filereadable('/opt/homebrew/bin/python3') == 1 then
        vim.g.python3_host_prog = '/opt/homebrew/bin/python3'
    end

    if vim.fn.filereadable("/usr/local/bin/neovim-node-host") == 1 then
        vim.g.neovim_host_prog = "/usr/local/bin/neovim-node-host"
    elseif vim.fn.filereadable("/opt/homebrew/bin/neovim-node-host") == 1 then
        vim.g.neovim_host_prog = "/opt/homebrew/bin/neovim-node-host"
    end

    local homedir = os.getenv("HOME")
    if vim.fn.filereadable(homedir .. "/.gem/bin/neovim-ruby-host") == 1 then
        vim.g.neovim_host_prog = homedir .. "/.gem/bin/neovim-ruby-host"
    end
end

local function configure_preferred_settings()
    vim.o.number = true
    vim.o.relativenumber = true
    vim.o.swapfile = false
    vim.o.list = true
    vim.o.listchars = "tab:» ,trail:·,extends:,precedes:,nbsp:+,eol:¶"
    vim.o.fillchars =
        'vert:│,stlnc: ,diff:·,eob: ,fold: ,foldopen:,foldclose:,foldsep:│'
    vim.o.laststatus = 3 -- global status bar
    vim.o.synmaxcol = 160
    vim.o.textwidth = 120
    vim.o.sidescrolloff = 20
    vim.o.scrolloff = 5
    vim.o.wrap = false
    vim.o.termguicolors = true
    vim.o.shiftwidth = 4
    vim.o.tabstop = 4
    vim.o.expandtab = true
    vim.o.mouse = ""

    vim.g.mapleader = " "
end

local function configure_preferred_mappings()
    local function noremap(mode, lhs, rhs, is_silent)
        if is_silent == nil then is_silent = true end
        vim.api.nvim_set_keymap(mode, lhs, rhs,
                                {silent = is_silent, noremap = true})
    end

    noremap("n", "<esc>", "<cmd>nohl<cr>")

    noremap("n", "<leader>tl", "<cmd>set list!<cr>")
    noremap("n", "<leader>tp", "<cmd>set paste!<cr>")
    noremap("n", "<leader>tw", "<cmd>set wrap!<cr>")
    noremap("n", "<leader>x", "<cmd>close!<cr>")

    -- rc files
    noremap("n", "!%", "<cmd>source ~/.config/nvim/init.lua<cr>")
    noremap("n", "!rh", "<cmd>e ~/.hammerspoon/init.lua<cr>")
    noremap("n", "!rv", "<cmd>e ~/.config/nvim/init.lua<cr>")
    noremap("n", "!rk", "<cmd>e ~/.config/kitty/kitty.conf<cr>")
    noremap("n", "!rz", "<cmd>e ~/.zshrc<cr>")

    -- split control
    noremap("n", "<s-left>", "<cmd>leftabove vsplit<cr>")
    noremap("n", "<s-right>", "<cmd>rightbelow vsplit<cr>")
    noremap("n", "<s-up>", "<cmd>leftabove split<cr>")
    noremap("n", "<s-down>", "<cmd>rightbelow split<cr>")
    noremap("n", "<c-l>", "<c-w>l")
    noremap("n", "<c-h>", "<c-w>h")
    noremap("n", "<c-j>", "<c-w>j")
    noremap("n", "<c-k>", "<c-w>k")

    -- Make visual mode yank and delete go to clipboard as well
    noremap("n", "vv", "viw")
    noremap("n", "vV", "viW")
    noremap("x", "y", "ygv\"*y")
    noremap("x", "d", "ygv\"*d")
    noremap("x", "x", "ygv\"*x")

    -- Make ZQ and ZZ more useful for multiple buffer situation
    -- TODO any way to integrate with dressing?
    noremap("n", "ZQ", ":confirm qa<cr>")
    noremap("n", "ZZ", ":confirm wqa<cr>")

    -- Add command like mapping
    -- command ctrl-e already mapped to <end>
    -- cnoremap <c-e> <end>
    -- cnoremap silent for <home> key causes cursor to freeze
    noremap("i", "<c-a>", "<c-o>I")
    noremap("i", "<c-e>", "<end>")
    noremap("i", "<c-k>", "<c-o>D")
    noremap("c", "<c-a>", "<home>", false)
    noremap("c", "<c-k>",
            "<c-\\>e(strpart(getcmdline(), 0, getcmdpos() - 1))<cr>", false)
    noremap("c", "<c-b>", "<left>", false)
    noremap("c", "<c-f>", "<right>", false)
    noremap("i", "<s-enter>", "<enter><c-o>k<c-o>Aa<c-o>==<c-o>A<bs>") -- `a<c-o>==<c-o>A<bs>` is to make auto indent work

    -- Add macos text edit mapping
    noremap("i", "<c-b>", "<left>")
    noremap("i", "<c-f>", "<right>")

    -- Add on to existing feature
    noremap("n", "gF", "<cmd>e %:h/<cfile><cr>")
end

local function configure_autogroup()
    vim.cmd [[
        augroup lAllFile
            autocmd!
            " BufWinEnter here is to override plugin that force the option
            " r,o: Continue comment
            " M,B: Don't insert space when joining Multibyte characters (e.g Chinese characters)
            " j: Remove comment leader when joining comment
            " q: Allow to use gq to format the selected block in visual mode
            " c: Autowrap comment
            " l: Don't autowrap if the line is already longer than text width
            autocmd BufWinEnter * setlocal formatoptions=roMBjqcl
        augroup END

        augroup lVim
            autocmd!
            autocmd FileType vim setlocal foldmethod=marker
        augroup END

        augroup lMarkdown
            autocmd!
            " Set textwidth-related formatoptions
            " t: Autowrap text/code
            autocmd BufWinEnter *.md setlocal formatoptions+=t

            " Allow bullet points or quote format to continue on line break
            " + shift-enter to not continue
            autocmd FileType markdown setlocal comments=fb:*,fb:-,fb:+,n:>,fb:1.

            " Shorten textwidth to markdown standard
            autocmd FileType markdown setlocal textwidth=80
        augroup END

        augroup lEcmascript
          autocmd!
          " Add missing information for jsx and tsx
          autocmd FileType typescriptreact set indentexpr=GetTypescriptIndent()
          autocmd FileType javascriptreact set indentexpr=GetJavascriptIndent()
        augroup END

        augroup lGitCommit
            autocmd!
            " Syntax highlight should be fixed by this PR? (Awaiting release)
            " https://github.com/neovim/neovim/pull/17007
            autocmd FileType gitcommit set comments=:;
            autocmd FileType gitcommit set commentstring=;\ %s
        augroup END

        augroup lFiletype
            autocmd!
            " direnv settings
            autocmd BufRead,BufNewFile .env* set ft=bash

            " Allow no highlighting for min files
            autocmd BufWinEnter *.min.* set ft=

            " Php
            autocmd BufRead,BufNewFile *.twig set ft=html
            " autoindent in indentexpr only works if syntax is on for PHP
            " https://github.com/nvim-treesitter/nvim-treesitter/issues/462#issuecomment-700278736
            autocmd BufRead,BufNewFile *.php syntax on

            " Because treesitter don't support zsh
            autocmd FileType zsh set ft=bash

            " SQL file comment
            autocmd FileType sql set commentstring=--\ %s

            " Plist is a xml file
            autocmd BufRead,BufNewFile *.plist setlocal ft=xml

            " Force .tf to be terraform instead of sometimes tf
            autocmd BufRead,BufNewFile *.tf setlocal ft=terraform
        augroup END
    ]]

    local awsconfig = "lAwsConfig"
    vim.api.nvim_create_augroup(awsconfig, {})
    vim.api.nvim_create_autocmd("BufRead", {
        pattern = "*/.aws/config",
        callback = function() vim.opt.filetype = 'toml' end,
        group = awsconfig
    })
end

local function configure_vim_diagnostics()
    for type, icon in pairs({
        Error = "",
        Warn = "",
        Hint = "ﯦ",
        Info = ""
    }) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, {text = icon, texthl = hl, numhl = hl})
    end

    vim.diagnostic.config({virtual_text = false, float = {source = true}})
end

function M.setup()
    configure_provider()
    configure_preferred_settings()
    configure_preferred_mappings()
    configure_autogroup()
    configure_vim_diagnostics()

    vim.o.foldtext = "v:lua.fold_text()"

    local homedir = os.getenv("HOME")
    if vim.fn.filereadable(homedir .. "/.vimrc_local") == 1 then
        vim.cmd [[source ~/.vimrc_local]]
    end
end

M.kind_icons = {
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

-- Better foldtext
function _G.fold_text()
    local leveltext = "   "
    for _ = 1, vim.v.foldlevel do leveltext = leveltext .. "" end
    local foldtext = vim.api.nvim_buf_get_lines(0, vim.v.foldstart - 1,
                                                vim.v.foldstart, false)[1]
    return leveltext .. " " .. foldtext
end

return M
