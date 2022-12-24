local M = {}

function M.setup()
    vim.api.nvim_set_keymap("n", '<c-enter>',
                            "<cmd>NvimTreeFindFile|NvimTreeOpen<cr>",
                            {noremap = true, silent = true})
    require'nvim-tree'.setup {
        disable_netrw = false,
        open_on_setup = false,
        hijack_cursor = true,
        diagnostics = {
            enable = true,
            icons = {hint = "", info = "", warning = "", error = ""}
        },
        view = {
            width = 30,
            hide_root_folder = true,
            mappings = {
                custom_only = true,
                list = {
                    -- :h nvim-tree-default-mappings
                    {key = 'a', action = "create"},
                    {key = '<CR>', action = "edit"},
                    {key = 'l', action = 'preview'},
                    {key = 'h', action = "close_node"},
                    {key = 'J', action = "next_sibling"},
                    {key = 'K', action = "prev_sibling"},
                    {key = 'dd', action = "cut"}, {key = 'yy', action = "copy"},
                    {key = 'p', action = "paste"},
                    {key = 'x', action = "remove"},
                    {key = 'r', action = "rename"},
                    {key = 'R', action = "refresh"},
                    {key = {'q', '<c-enter>'}, action = "close"},
                    {key = {'zh'}, action = "toggle_git_ignored"},
                    {key = '<C-k>', action = ''},
                    {key = 'gp', action = 'parent_node'}
                }
            }
        },
        filters = {custom = {"__pycache__"}},
        actions = {
            open_file = {
                quit_on_open = true,
                window_picker = {
                    enable = true,
                    chars = "aoeuhtns",
                    exclude = {
                        filetype = {
                            "notify", "packer", "qf", "Trouble", "aerial"
                        }
                    }
                },
                resize_window = true
            },
            remove_file = {close_window = false}
        },
        renderer = {
            group_empty = true,
            highlight_git = false,
            icons = {
                glyphs = {
                    git = {
                        unstaged = "",
                        deleted = "✖ ",
                        staged = " ",
                        unmerged = " ",
                        renamed = " ",
                        untracked = " ",
                        ignored = "◌ "
                    }

                }
            }
        }
    }

    local theme = require('common-theme')
    theme.set_hl('NvimTreeGitDeleted', {fg = theme.blender.delete})
    theme.set_hl('NvimTreeGitDirty', {fg = theme.blender.change})
    theme.set_hl('NvimTreeGitIgnored', {fg = theme.blender.bg_lighter_3})
    theme.set_hl('NvimTreeGitMerge', {fg = 6})
    theme.set_hl('NvimTreeGitNew', {fg = theme.blender.add})
    theme.set_hl('NvimTreeGitRenamed', {fg = theme.blender.change})
    theme.set_hl('NvimTreeGitStaged', {fg = 6})
    theme.set_hl('NvimTreeFolderIcon', {link = 'Directory'})
    theme.set_hl('NvimTreeExecFile', {fg = 2, bold = true})
    theme.set_hl('NvimTreeSymlink', {fg = 6, bold = true})
    theme.set_hl('NvimTreeEndOfBuffer', {bg = 0})

    local events = require("nvim-tree.api").events
    events.subscribe(events.Event.TreeOpen,
                     function() vim.opt_local.cursorline = true end)

end

return M
