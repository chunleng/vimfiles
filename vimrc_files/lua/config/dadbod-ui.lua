local M = {}

function M.beforeSetup()
    -- global variables are not initialized properly in packer.config()
    -- and therefore we need to initialize them in packer.setup()
    vim.g.db_ui_use_nerd_fonts = 1
    vim.g.db_ui_show_database_icon = 1
end

function M.setup()
    vim.api.nvim_set_keymap('n', '<leader>td', '<cmd>DBUIToggle<cr>',
                            {noremap = true, silent = true})
    vim.g.db_ui_win_position = 'right'
    vim.g.db_ui_table_helpers = {
        postgresql = {
            List = "SELECT * FROM {optional_schema}{table} ORDER BY 1 LIMIT 20",
            Columns = "SELECT\n  ordinal_position,\n  column_name,\n  udt_name,\n  is_nullable,\n  character_octet_length\n" ..
                "FROM information_schema.columns WHERE table_name='{table}' AND table_schema='{schema}' ORDER BY ordinal_position",
            Count = "SELECT COUNT(*) FROM {optional_schema}{table}"
        }
    }
end

return M