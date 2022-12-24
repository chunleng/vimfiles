local M = {}

local function configure_provider()
    if vim.fn.filereadable('/usr/local/bin/python3') == 1 then
        vim.g.python3_host_prog = '/usr/local/bin/python3'
    elseif vim.fn.filereadable('/opt/homebrew/bin/python3') == 1 then
        vim.g.python3_host_prog = '/opt/homebrew/bin/python3'
    end

    local homedir = os.getenv("HOME")
    if vim.fn.filereadable(homedir ..
                               "/.asdf/installs/nodejs/lts-gallium/bin/neovim-node-host") ==
        1 then
        vim.g.node_host_prog = homedir ..
                                   "/.asdf/installs/nodejs/lts-gallium/bin/neovim-node-host"
    end

    if vim.fn.filereadable(homedir .. "/.gem/bin/neovim-ruby-host") == 1 then
        vim.g.neovim_host_prog = homedir .. "/.gem/bin/neovim-ruby-host"
    end
end

local function configure_preferred_settings()
    vim.o.number = true
    vim.o.relativenumber = false
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

    M.noremap("n", "<esc>", "<cmd>nohl<cr>")

    M.noremap("n", "<leader>tu", "<cmd>set termguicolors!<cr>")
    M.noremap("n", "<leader>tl", "<cmd>set list!<cr>")
    M.noremap("n", "<leader>tp", "<cmd>set paste!<cr>")
    M.noremap("n", "<leader>tw", "<cmd>set wrap!<cr>")
    M.noremap("n", "<c-w><c-q>", "<cmd>close!<cr>")

    -- rc files
    M.noremap("n", "!%", "<cmd>source ~/.config/nvim/init.lua<cr>")
    M.noremap("n", "!rh", "<cmd>e ~/.hammerspoon/init.lua<cr>")
    M.noremap("n", "!rv", "<cmd>e ~/.config/nvim/init.lua<cr>")
    M.noremap("n", "!rk", "<cmd>e ~/.config/kitty/kitty.conf<cr>")
    M.noremap("n", "!rz", "<cmd>e ~/.zshrc<cr>")

    -- split control
    M.noremap("n", "<c-l>", "<c-w>l")
    M.noremap("n", "<c-h>", "<c-w>h")
    M.noremap("n", "<c-j>", "<c-w>j")
    M.noremap("n", "<c-k>", "<c-w>k")

    -- Make visual mode yank and delete go to clipboard as well
    M.noremap("n", "vv", "viw")
    M.noremap("n", "vV", "viW")
    M.noremap("x", "y", "ygv\"*y")
    M.noremap("x", "d", "ygv\"*d")
    M.noremap("x", "x", "ygv\"*x")

    -- Make ZQ and ZZ more useful for multiple buffer situation
    -- TODO any way to integrate with dressing?
    M.noremap("n", "ZQ", ":confirm qa<cr>")
    M.noremap("n", "ZZ", ":confirm wqa<cr>")

    -- Add command like mapping
    -- command ctrl-e already mapped to <end>
    -- cM.noremap <c-e> <end>
    -- cM.noremap silent for <home> key causes cursor to freeze
    M.noremap("i", "<c-a>", "<c-o>I")
    M.noremap("i", "<c-e>", "<end>")
    M.noremap("i", "<c-k>", "<c-o>D")
    M.noremap("c", "<c-a>", "<home>", false)
    M.noremap("c", "<c-k>",
              "<c-\\>e(strpart(getcmdline(), 0, getcmdpos() - 1))<cr>", false)
    M.noremap("c", "<c-b>", "<left>", false)
    M.noremap("c", "<c-f>", "<right>", false)
    M.noremap("i", "<s-enter>", "<enter><c-o>k<c-o>Aa<c-o>==<c-o>A<bs>") -- `a<c-o>==<c-o>A<bs>` is to make auto indent work

    -- Add macos text edit mapping
    M.noremap("i", "<c-b>", "<left>")
    M.noremap("i", "<c-f>", "<right>")

    -- Add on to existing feature
    M.noremap("n", "gF", "<cmd>e %:h/<cfile><cr>")

    -- Make cycling between easier
    M.noremap('n', '<bs>', '<cmd>b #<cr>')
    M.noremap('n', '<c-bs>', '<cmd>wincmd p<cr>')
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
            autocmd FileType qf nnoremap <buffer> <silent> l <cr><c-w>p
            autocmd FileType qf nnoremap <buffer> <silent> J j<cr><c-w>p
            autocmd FileType qf nnoremap <buffer> <silent> K k<cr><c-w>p
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
    local leveltext = "   "
    for _ = 1, vim.v.foldlevel do leveltext = leveltext .. "" end
    local foldtext = vim.api.nvim_buf_get_lines(0, vim.v.foldstart - 1,
                                                vim.v.foldstart, false)[1]
    return leveltext .. " " .. foldtext
end

function M.noremap(mode, lhs, rhs, is_silent)
    if is_silent == nil then is_silent = true end
    vim.keymap.set(mode, lhs, rhs, {silent = is_silent, noremap = true})
end

return M
