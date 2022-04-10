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

    if vim.fn.filereadable("/usr/local/bin/neovim-ruby-host") == 1 then
        vim.g.neovim_host_prog = "/usr/local/bin/neovim-ruby-host"
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
    vim.o.laststatus = 2 -- Show statusline always
    vim.o.synmaxcol = 160
    vim.o.textwidth = 120
    vim.o.sidescrolloff = 20
    vim.o.scrolloff = 5
    vim.o.wrap = false
    vim.g.mapleader = " "
    vim.o.termguicolors = true
end

function M.setup()
    configure_provider()
    configure_preferred_settings()
    vim.o.foldtext = "v:lua.fold_text()"
end

-- Better foldtext
function _G.fold_text()
    local leveltext = "   "
    for _ = 1, vim.v.foldlevel do leveltext = leveltext .. "" end
    local foldtext = vim.api.nvim_buf_get_lines(0, vim.v.foldstart - 1,
                                                vim.v.foldstart, false)[1]
    return leveltext .. " " .. foldtext
end

return M
