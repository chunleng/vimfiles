local M = {}

function M.setup()
    local utils = require('common-utils')
    local api = require("nvim-tree.api")

    utils.keymap("n", '<c-s-enter>', "<cmd>NvimTreeFindFile|NvimTreeOpen<cr>")

    require'nvim-tree'.setup {
        disable_netrw = false,
        hijack_cursor = true,
        diagnostics = {
            enable = true,
            icons = {hint = "", info = "", warning = "", error = ""}
        },
        view = {width = 30},
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
            root_folder_label = false,
            icons = {
                glyphs = {
                    git = {
                        unstaged = "",
                        deleted = "✖ ",
                        staged = " ",
                        unmerged = " ",
                        renamed = " ",
                        untracked = " ",
                        ignored = "◌ "
                    }

                }
            }
        },
        on_attach = function(bufnr)
            utils.buf_keymap(bufnr, 'n', 'a', api.fs.create)
            utils.buf_keymap(bufnr, 'n', {'<cr>', 'e'}, api.node.open.edit)
            -- TODO handle node.type == 'link'
            utils.buf_keymap(bufnr, 'n', 'l', function()
                local node = api.tree.get_node_under_cursor()
                if node.type == 'file' then
                    api.node.open.preview()
                else
                    if not node.open then
                        api.node.open.edit()
                    end
                    -- Goto child
                    -- TODO The following goes to the next folder when child is empty
                    vim.api.nvim_feedkeys('j', 'n', false)
                end
            end)
            utils.buf_keymap(bufnr, 'n', 'h', function()
                local node = api.tree.get_node_under_cursor()
                print(node.type)
                if node.type == 'directory' and node.open then
                    api.node.open.edit()
                else
                    api.node.navigate.parent_close()
                end
            end)
            utils.buf_keymap(bufnr, 'n', 'J', api.node.navigate.sibling.next)
            utils.buf_keymap(bufnr, 'n', 'K', api.node.navigate.sibling.prev)
            utils.buf_keymap(bufnr, 'n', 'dd', api.fs.cut)
            utils.buf_keymap(bufnr, 'n', 'yy', api.fs.copy.node)
            utils.buf_keymap(bufnr, 'n', 'p', api.fs.paste)
            utils.buf_keymap(bufnr, 'n', 'x', api.fs.remove)
            utils.buf_keymap(bufnr, 'n', 'r', api.fs.rename)
            utils.buf_keymap(bufnr, 'n', 'R', api.tree.reload)
            utils.buf_keymap(bufnr, 'n', {'q', '<c-s-enter>'}, api.tree.close)
            utils.buf_keymap(bufnr, 'n', 'zh', api.tree.toggle_gitignore_filter)
            utils.buf_keymap(bufnr, 'n', 'gp', api.node.navigate.parent)
        end
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

    local events = api.events
    events.subscribe(events.Event.TreeOpen,
                     function() vim.opt_local.cursorline = true end)

end

return M
