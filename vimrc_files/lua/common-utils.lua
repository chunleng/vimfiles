local M = {}

local function configure_provider()
    local homedir = os.getenv("HOME")

    if vim.fn.filereadable(homedir ..
                               '/.asdf/installs/python/3.11.4/bin/python3') == 1 then
        -- Allow running of correct version even if using virtualenv
        vim.g.python3_host_prog =
            'zsh --login --interactive -c "asdf shell python 3.11.4 && python"'
    end

    if vim.fn.filereadable(homedir ..
                               "/.asdf/installs/nodejs/18.16.1/bin/neovim-node-host") ==
        1 then
        vim.g.node_host_prog = homedir ..
                                   "/.asdf/installs/nodejs/18.16.1/bin/neovim-node-host"
    end

    if vim.fn.filereadable(homedir .. "/.gem/bin/neovim-ruby-host") == 1 then
        vim.g.neovim_host_prog = homedir .. "/.gem/bin/neovim-ruby-host"
    end
end

local function configure_preferred_settings()
    vim.o.number = true
    vim.o.relativenumber = true
    vim.o.swapfile = false
    vim.o.list = true
    vim.o.listchars = "tab:⇥ ,trail:·,extends:,precedes:,nbsp:+,eol: "
    vim.o.fillchars = 'stlnc: ,diff:·,eob: ,fold: ,foldopen:,foldclose:'
    vim.o.laststatus = 3 -- global status bar
    vim.o.synmaxcol = 160
    vim.o.textwidth = 120
    vim.o.sidescrolloff = 20
    vim.o.scrolloff = 5
    vim.o.wrap = false
    vim.o.shiftwidth = 4
    vim.o.tabstop = 4
    vim.o.expandtab = true
    vim.o.mouse = ""
    vim.o.foldcolumn = '1'
    vim.o.foldnestmax = 9
    vim.o.foldminlines = 10
    vim.o.colorcolumn = '+1,+' .. vim.fn.join(vim.fn.range(2, 100), ',+')

    vim.g.mapleader = " "
end

local function configure_preferred_mappings()

    M.keymap("n", "<esc>", "<cmd>nohl<cr>")

    M.keymap("n", "<leader>tu", "<cmd>set termguicolors!<cr>")
    M.keymap("n", "<leader>tl", "<cmd>set list!<cr>")
    M.keymap("n", "<leader>tp", "<cmd>set paste!<cr>")
    M.keymap("n", "<leader>tw", "<cmd>set wrap!<cr>")
    M.keymap("n", "<c-w><c-q>", "<cmd>close!<cr>")

    -- split control
    M.keymap("n", "<c-l>", "<c-w>l")
    M.keymap("n", "<c-h>", "<c-w>h")
    M.keymap("n", "<c-j>", "<c-w>j")
    M.keymap("n", "<c-k>", "<c-w>k")

    -- Make visual mode yank and delete go to clipboard as well
    M.keymap("n", "vv", "viw")
    M.keymap("n", "vV", "viW")
    M.keymap("x", "y", "ygv\"*y")
    M.keymap("x", "d", "ygv\"*d")
    M.keymap("x", "x", "ygv\"*x")

    -- Make ZQ and ZZ more useful for multiple buffer situation
    -- TODO any way to integrate with dressing?
    M.keymap("n", "ZQ", ":confirm qa<cr>")
    M.keymap("n", "ZZ", ":confirm wqa<cr>")
    M.keymap('n', '<c-s>', '<cmd>w<cr>')
    M.keymap('i', '<c-s>', '<esc><cmd>w<cr>')

    -- Add command like mapping
    -- command ctrl-e already mapped to <end>
    -- cM.noremap <c-e> <end>
    -- cM.noremap silent for <home> key causes cursor to freeze
    M.keymap("i", "<c-a>", "<c-o>I")
    M.keymap("i", "<c-e>", "<end>")
    M.keymap("i", "<c-k>", "<c-o>D")
    M.keymap("c", "<c-a>", "<home>", {silent = false})
    M.keymap("c", "<c-k>",
             "<c-\\>e(strpart(getcmdline(), 0, getcmdpos() - 1))<cr>",
             {silent = false})
    M.keymap("c", "<c-b>", "<left>", {silent = false})
    M.keymap("c", "<c-f>", "<right>", {silent = false})

    -- Add macos text edit mapping
    M.keymap("i", "<c-b>", "<left>")
    M.keymap("i", "<c-f>", "<right>")

    -- Make cycling between easier
    M.keymap('n', '<bs>', '<cmd>b #<cr>')
    M.keymap('n', '<c-bs>', '<cmd>wincmd p<cr>')

    -- Faster completion
    M.keymap('i', '<c-l>', '<c-x><c-l>')

    -- Easier reach to [, ]
    M.keymap({'n', 'x'}, '<c-,>', function() vim.fn.eval('feedkeys("[")') end)
    M.keymap({'n', 'x'}, '<c-.>', function() vim.fn.eval('feedkeys("]")') end)

    -- Yank
    M.keymap('i', '<c-y>', '<esc>0"*y$gi')
    M.keymap('c', '<c-y>', function()
        local t = vim.fn.getcmdtype()
        -- 4x \\<c-c> is to escape previously opened q:, q/ and q? dialog
        -- However, for the case where dialog is opened, it might not work properly
        -- TODO find out how to detect the window that is opened and deal with it properly
        if vim.tbl_contains({':', '/', '?'}, t) then
            vim.fn.eval('feedkeys("\\<c-c>q' .. t .. 'k\\"*y$\\<c-c>\\<c-c>' ..
                            t .. '\\<c-p>")')
        end
    end)

    -- Prevent accidentally quiting
    M.keymap({'n', 'x'}, '<c-s-z>', function() end)
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

        augroup lQf
            autocmd!
            " Always open at the bottom edge
            autocmd FileType qf wincmd J
            " Reduce height by 5 (qf defaults to 10)
            autocmd FileType qf wincmd 5-
            " Preview
            autocmd FileType qf nnoremap <buffer> <silent> <cr> <cr>
            autocmd FileType qf nnoremap <buffer> <silent> l <cr><c-w>p
            autocmd FileType qf nnoremap <buffer> <silent> J j<cr><c-w>p
            autocmd FileType qf nnoremap <buffer> <silent> K k<cr><c-w>p
            autocmd FileType qf nnoremap <buffer> <silent> q <cmd>close<cr>
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
        Hint = "",
        Info = ""
    }) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, {text = icon, texthl = hl, numhl = hl})
    end

    vim.diagnostic.config({
        virtual_text = false,
        float = {source = true},
        signs = false
    })
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
    Text = " ",
    Method = " ",
    Function = " ",
    Constructor = "󰖷",
    Field = " ",
    Variable = " ",
    Class = " ",
    Interface = " ",
    Module = " ",
    Property = " ",
    Unit = " ",
    Value = " ",
    Enum = " ",
    Keyword = " ",
    Snippet = " ",
    Color = " ",
    File = " ",
    Reference = " ",
    Folder = " ",
    EnumMember = " ",
    Constant = " ",
    Struct = " ",
    Event = " ",
    Operator = " ",
    TypeParameter = " ",
    Array = " ",
    Number = " ",
    Boolean = " ",
    String = " "
}

-- Better foldtext
function _G.fold_text()
    local leveltext = "   "
    for _ = 2, vim.v.foldlevel do leveltext = leveltext .. "" end
    local foldtext = vim.api.nvim_buf_get_lines(0, vim.v.foldstart - 1,
                                                vim.v.foldstart, false)[1]
    return leveltext .. " " .. foldtext
end

function M.keymap(mode, lhs, rhs, opt)
    lhs = type(lhs) == 'string' and {lhs} or lhs
    opt = opt or {}

    for i = 1, #lhs do
        opt = vim.tbl_extend('force', {silent = true, noremap = false}, opt)
        vim.keymap.set(mode, lhs[i], rhs, opt)
    end
end

function M.buf_keymap(b, mode, lhs, rhs, opt)
    opt = vim.tbl_extend('force', opt or {}, {buffer = b})
    M.keymap(mode, lhs, rhs, opt)
end
return M
