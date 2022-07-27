local M = {}

function M.setup()
    vim.api.nvim_set_keymap("n", "<leader><space>", "<cmd>NvimTreeFindFile<cr>",
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
                    {key = 'q', action = "close"},
                    {
                        key = {'<C-h>', '<backspace>'},
                        action = "toggle_git_ignored"
                    }, {key = '<C-k>', action = ''}
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
            }
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

    require("nvim-tree.events").on_tree_open(function()
        vim.opt_local.cursorline = true
    end)

end

return M
