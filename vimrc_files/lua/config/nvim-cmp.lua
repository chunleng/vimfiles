local M = {}

function M.setup()
    local cmp = require 'cmp'
    local compare = require 'cmp.config.compare'
    local kind_icons = require("common-utils").kind_icons

    cmp.setup({
        -- Since I my sorting prioritize exact elements first, preselect is not required
        preselect = require("cmp.types").cmp.PreselectMode.None,
        formatting = {
            format = function(entry, vim_item)
                local prsnt, lspkind = pcall(require, "lspkind")
                if not prsnt then
                    -- Kind icons
                    vim_item.kind = string.format('%s %s',
                                                  kind_icons[vim_item.kind],
                                                  vim_item.kind) -- This concatenates the icons with the name of the item kind
                    -- Source
                    vim_item.menu = ({
                        path = "│",
                        ultisnips = "│",
                        nvim_lsp = "│ LSP",
                        buffer = "│ Buffer",
                        ["vim-dadbod-completion"] = "│ DB"
                    })[entry.source.name]
                    return vim_item
                else
                    return lspkind.cmp_format()
                end
            end
        },
        sorting = {
            comparators = {
                function(entry1, entry2)
                    -- Exact that is snippet
                    local worthy_exact1 = entry1.exact and
                                              (entry1.completion_item.insertText ~=
                                                  nil or
                                                  entry1.completion_item
                                                      .textEdit ~= nil)
                    local worthy_exact2 = entry2.exact and
                                              (entry2.completion_item.insertText ~=
                                                  nil or
                                                  entry2.completion_item
                                                      .textEdit ~= nil)
                    if worthy_exact1 ~= worthy_exact2 then
                        return worthy_exact1
                    end
                end, compare.recently_used, function(entry1, entry2)
                    -- Custom sorting that prioritize via a combination of the following criteria
                    -- * Not exact (leave it to exact sorting)
                    -- * Less fuzziness (higher score)
                    -- * Snippet first
                    local score1 = entry1.exact and 0 or (entry1.score +
                                       ((entry1.completion_item.insertText ~=
                                           nil or
                                           entry1.completion_item.textEdit ~=
                                           nil) and 1 or 0))
                    local score2 = entry2.exact and 0 or (entry2.score +
                                       ((entry2.completion_item.insertText ~=
                                           nil or
                                           entry2.completion_item.textEdit ~=
                                           nil) and 1 or 0))
                    local diff = score2 - score1
                    if diff < 0 then
                        return true
                    elseif diff > 0 then
                        return false
                    end
                end, compare.sort_text
            }
        },
        sources = {
            {name = 'path', priority = 100},
            {name = 'ultisnips', priority = 35},
            {name = 'nvim_lsp', max_item_count = 100, priority = 30},
            {name = "vim-dadbod-completion", priority = 30}, {
                name = 'buffer',
                max_item_count = 10,
                priority = 1,
                option = {
                    -- https://github.com/hrsh7th/cmp-buffer#visible-buffers
                    get_bufnrs = function()
                        local bufs = {}
                        for _, win in ipairs(vim.api.nvim_list_wins()) do
                            -- TODO https://github.com/hrsh7th/cmp-buffer#performance-on-large-text-files
                            bufs[vim.api.nvim_win_get_buf(win)] = true
                        end
                        return vim.tbl_keys(bufs)
                    end
                }
            }
        },
        mapping = cmp.mapping.preset.insert({
            ['<tab>'] = cmp.mapping.confirm {
                behavior = cmp.ConfirmBehavior.Replace,
                select = true
            },
            ['<c-e>'] = function()
                local key = vim.api.nvim_replace_termcodes('<end>', true, false,
                                                           true)
                vim.api.nvim_feedkeys(key, 'i', false)
            end,
            ['<c-a>'] = function()
                local key = vim.api.nvim_replace_termcodes('<home>', true,
                                                           false, true)
                vim.api.nvim_feedkeys(key, 'i', false)
            end,
            ['<s-down>'] = cmp.mapping.scroll_docs(4),
            ['<s-up>'] = cmp.mapping.scroll_docs(-4)
        }),
        snippet = {
            expand = function(args)
                vim.fn["UltiSnips#Anon"](args.body)
            end
        },
        completion = {
            autocomplete = {
                cmp.TriggerEvent.TextChanged, cmp.TriggerEvent.InsertEnter
            }
        }
    })

    local base16 = require("base16-colorscheme")
    vim.api.nvim_set_hl(0, "CmpItemMenu",
                        {italic = true, fg = base16.colors.base03})
    -- blue
    vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", {fg = base16.colors.base0D})
    vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", {fg = base16.colors.base0D})
    -- orange
    vim.api.nvim_set_hl(0, "CmpItemKindFunction", {fg = base16.colors.base09})
    vim.api.nvim_set_hl(0, "CmpItemKindMethod", {fg = base16.colors.base09})
    vim.api
        .nvim_set_hl(0, "CmpItemKindConstructor", {fg = base16.colors.base09})
    vim.api.nvim_set_hl(0, "CmpItemKindClass", {fg = base16.colors.base09})
    vim.api.nvim_set_hl(0, "CmpItemKindInterface", {fg = base16.colors.base09})
    vim.api.nvim_set_hl(0, "CmpItemKindModule", {fg = base16.colors.base09})
    vim.api.nvim_set_hl(0, "CmpItemKindEnum", {fg = base16.colors.base09})
    vim.api.nvim_set_hl(0, "CmpItemKindStruct", {fg = base16.colors.base09})
    -- turquoise
    vim.api.nvim_set_hl(0, "CmpItemKindVariable", {fg = base16.colors.base0C})
    vim.api.nvim_set_hl(0, "CmpItemKindText", {fg = base16.colors.base0C})
    vim.api.nvim_set_hl(0, "CmpItemKindField", {fg = base16.colors.base0C})
    vim.api.nvim_set_hl(0, "CmpItemKindProperty", {fg = base16.colors.base0C})
    vim.api.nvim_set_hl(0, "CmpItemKindValue", {fg = base16.colors.base0C})
    vim.api.nvim_set_hl(0, "CmpItemKindEnumMember", {fg = base16.colors.base0C})
    vim.api.nvim_set_hl(0, "CmpItemKindTypeParameter",
                        {fg = base16.colors.base0C})
    vim.api.nvim_set_hl(0, "CmpItemKindConstant", {fg = base16.colors.base0C})
    -- yellow
    vim.api.nvim_set_hl(0, "CmpItemKindUnit", {fg = base16.colors.base0A})
    vim.api.nvim_set_hl(0, "CmpItemKindKeyword", {fg = base16.colors.base0A})
    vim.api.nvim_set_hl(0, "CmpItemKindOperator", {fg = base16.colors.base0A})
    vim.api.nvim_set_hl(0, "CmpItemKindColor", {fg = base16.colors.base0A})
    -- default
    vim.api.nvim_set_hl(0, "CmpItemKind", {fg = base16.colors.base03})
end

return M
