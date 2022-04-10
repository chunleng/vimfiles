local M = {}

function _G.handle_aerial_open()
    local window_ids = vim.api.nvim_tabpage_list_wins(0)
    local editing_win_count = 0
    local ignore_ft = {
        NvimTree = true,
        aerial = true,
        dashboard = true,
        gitcommit = true,
        Mundo = true,
        MundoDiff = true,
        [""] = true -- no filetype
    }
    for _, wid in ipairs(window_ids) do
        local bufnr = vim.api.nvim_win_get_buf(wid)
        local ft = vim.api.nvim_buf_get_option(bufnr, "ft")
        local win_opt = vim.api.nvim_win_get_config(wid)

        -- Not floating window or functional filetype
        if win_opt.zindex == nil and win_opt.focusable and not ignore_ft[ft] then
            editing_win_count = editing_win_count + 1
        end
    end

    local is_open = false
    for _, wid in ipairs(window_ids) do
        local bufnr = vim.api.nvim_win_get_buf(wid)
        local ft = vim.api.nvim_buf_get_option(bufnr, "ft")

        if ft == "aerial" then
            is_open = true
            break
        end
    end

    if editing_win_count == 1 then
        if not is_open then require("aerial").open() end
    elseif is_open then
        require("aerial").close()
    end
end

function M.setup()
    local kind_icons = require("common-utils").kind_icons
    local js_kind = {
        "Class", "Constructor", "Enum", "Function", "Interface", "Module",
        "Method", "Struct", "Constant", "Variable", "Field"
    }
    local data_kind = {"Module", "Number", "Array", "Boolean", "String"}
    require("aerial").setup({
        backends = {"lsp", "treesitter", "markdown"}, -- LSP is still more stable, prioritize LSP first
        min_width = 30,
        max_width = 30,
        show_guide = true,
        placement_editor_edge = true,
        icons = kind_icons,
        filter_kind = {
            ['_'] = {
                "Class", "Constructor", "Enum", "Function", "Interface",
                "Module", "Method", "Struct"
            },
            typescriptreact = js_kind,
            javascriptreact = js_kind,
            typescript = js_kind,
            javascript = js_kind,
            json = data_kind,
            yaml = data_kind
        },
        default_direction = "right"
    })
    local base16 = require("base16-colorscheme")
    vim.highlight.create("AerialLine", {
        guifg = "none",
        guibg = base16.colors.base0A_20,
        blend = 0
    }, false)

    vim.cmd [[
        augroup Aerial
            autocmd!
            autocmd BufEnter,WinEnter * silent! call v:lua.handle_aerial_open()
        augroup END
    ]]
end

return M
