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

    vim.g.mapleader = " "
end

local function configure_preferred_mappings()
    local function noremap(mode, lhs, rhs)
        vim.api.nvim_set_keymap(mode, lhs, rhs, {silent = true, noremap = true})
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
    noremap("v", "y", "ygv\"*y")
    noremap("v", "d", "ygv\"*d")
    noremap("v", "x", "ygv\"*x")

    -- Make ZQ and ZZ more useful for multiple buffer situation
    -- TODO any way to integrate with dressing?
    noremap("n", "ZQ", ":confirm qa<cr>")
    noremap("n", "ZZ", ":confirm wqa<cr>")

    -- Add command like mapping
    -- command ctrl-e already mapped to <end>
    -- cnoremap <c-e> <end>
    noremap("i", "<c-a>", "<home>")
    noremap("i", "<c-e>", "<end>")
    noremap("c", "<c-a>", "<home>")

end

local function configure_autogroup()
    vim.cmd [[
        augroup allfile
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

        augroup vim
            autocmd!
            autocmd FileType vim setlocal foldmethod=marker
        augroup END

        augroup markdown
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

        augroup ecmascript
          autocmd!
          " Add missing information for jsx and tsx
          autocmd FileType typescriptreact set indentexpr=GetTypescriptIndent()
          autocmd FileType javascriptreact set indentexpr=GetJavascriptIndent()
        augroup END

        augroup gitcommit
            autocmd!
            " Syntax highlight should be fixed by this PR? (Awaiting release)
            " https://github.com/neovim/neovim/pull/17007
            autocmd FileType gitcommit set comments=:;
            autocmd FileType gitcommit set commentstring=;\ %s
        augroup END

        augroup custom_filetype
            autocmd!
            " direnv settings
            autocmd BufRead,BufNewFile .env* set ft=bash

            " Allow no highlighting for min files
            autocmd BufWinEnter *.min.* set ft=

            " Php
            autocmd BufRead,BufNewFile *.twig set ft=php

            " Because treesitter don't support zsh
            autocmd FileType zsh :set ft=bash

            " Plist is a xml file
            autocmd BufRead,BufNewFile *.plist setlocal ft=xml
        augroup END
    ]]

    local awsconfig = "aws_config"
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
