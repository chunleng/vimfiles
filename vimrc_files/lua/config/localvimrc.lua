local M = {}

function M.setup()
    vim.g.localvimrc_name = {".vim/local.vim", '.vim/local.lua'}
    vim.g.localvimrc_file_directory_only = 0

    -- Disable sandbox to enable running of autocmd
    -- NOTE: do not remove ask, only accept if you know the content of vimrc
    vim.g.localvimrc_sandbox = 0
    vim.g.localvimrc_ask = 1

    --  Store decision to source local vimrc
    vim.g.localvimrc_persistent = 2
end

return M
