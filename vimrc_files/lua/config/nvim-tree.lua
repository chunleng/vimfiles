local M = {}

function M.setup()
    vim.api.nvim_set_keymap("n", "<leader><space>", "<cmd>NvimTreeFindFile<cr>",
                            {noremap = true, silent = true})
    require'nvim-tree'.setup {
        disable_netrw = false,
        open_on_setup = true,
        hijack_cursor = true,
        diagnostics = {
            enable = true,
            icons = {hint = "", info = "", warning = "", error = ""}
        },
        view = {width = 30, hide_root_folder = true, auto_resize = true},
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
                }
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
end

return M
