local M = {}

function M.setup()
    vim.api.nvim_set_keymap("n", "<c-space>", "<cmd>NvimTreeFindFile<cr>",
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
                    {key = {'l', '<CR>'}, action = "edit"},
                    {key = 'h', action = "close_node"},
                    {key = 'J', action = "next_sibling"},
                    {key = 'K', action = "prev_sibling"},
                    {key = 'dd', action = "cut"}, {key = 'yy', action = "copy"},
                    {key = 'p', action = "paste"},
                    {key = 'x', action = "remove"},
                    {key = 'r', action = "rename"},
                    {key = 'R', action = "refresh"},
                    {key = {'q', "<c-space>"}, action = "close"},
                    {key = {'<C-h>'}, action = "toggle_git_ignored"},
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
            highlight_git = true,
            icons = {
                glyphs = {
                    git = {
                        unstaged = "",
                        staged = "",
                        unmerged = "",
                        renamed = "→",
                        untracked = "?",
                        deleted = "",
                        ignored = "◌"
                    }

                }
            }
        }
    }

    local events = require("nvim-tree.api").events
    events.subscribe(events.Event.TreeOpen,
                     function() vim.opt_local.cursorline = true end)

end

return M
