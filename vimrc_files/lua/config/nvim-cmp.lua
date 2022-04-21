local M = {}

function M.setup()
    local cmp = require 'cmp'
    local compare = require 'cmp.config.compare'
    local kind_icons = require("common-utils").kind_icons

    cmp.setup({
        formatting = {
            format = function(entry, vim_item)
                local prsnt, lspkind = pcall(require, "lspkind")
                if not prsnt then
                    -- Kind icons
                    vim_item.kind = string.format('%s %s',
                                                  kind_icons[vim_item.kind],
                                                  vim_item.kind) -- This concatonates the icons with the name of the item kind
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
            ['<c-e>'] = cmp.mapping.close {},
            ['<c-a>'] = cmp.mapping.close {},
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
    vim.highlight.create("CmpItemMenuDefault",
                         {gui = "italic", guifg = base16.colors.base03}, false)
    vim.highlight.create("CmpItemMenuDefault",
                         {gui = "italic", guifg = base16.colors.base03}, false)
    -- blue
    vim.highlight.create("CmpItemAbbrMatch", {guifg = base16.colors.base0D},
                         false)
    vim.highlight.create("CmpItemAbbrMatchFuzzy",
                         {guifg = base16.colors.base0D}, false)
    -- orange
    vim.highlight.create("CmpItemKindFunction", {guifg = base16.colors.base09},
                         false)
    vim.highlight.create("CmpItemKindMethod", {guifg = base16.colors.base09},
                         false)
    vim.highlight.create("CmpItemKindConstructor",
                         {guifg = base16.colors.base09}, false)
    vim.highlight.create("CmpItemKindClass", {guifg = base16.colors.base09},
                         false)
    vim.highlight.create("CmpItemKindInterface", {guifg = base16.colors.base09},
                         false)
    vim.highlight.create("CmpItemKindModule", {guifg = base16.colors.base09},
                         false)
    vim.highlight.create("CmpItemKindEnum", {guifg = base16.colors.base09},
                         false)
    vim.highlight.create("CmpItemKindStruct", {guifg = base16.colors.base09},
                         false)
    -- turquoise
    vim.highlight.create("CmpItemKindVariable", {guifg = base16.colors.base0C},
                         false)
    vim.highlight.create("CmpItemKindText", {guifg = base16.colors.base0C},
                         false)
    vim.highlight.create("CmpItemKindField", {guifg = base16.colors.base0C},
                         false)
    vim.highlight.create("CmpItemKindProperty", {guifg = base16.colors.base0C},
                         false)
    vim.highlight.create("CmpItemKindValue", {guifg = base16.colors.base0C},
                         false)
    vim.highlight.create("CmpItemKindEnumMember",
                         {guifg = base16.colors.base0C}, false)
    vim.highlight.create("CmpItemKindTypeParameter",
                         {guifg = base16.colors.base0C}, false)
    vim.highlight.create("CmpItemKindConstant", {guifg = base16.colors.base0C},
                         false)
    -- yellow
    vim.highlight.create("CmpItemKindUnit", {guifg = base16.colors.base0A},
                         false)
    vim.highlight.create("CmpItemKindKeyword", {guifg = base16.colors.base0A},
                         false)
    vim.highlight.create("CmpItemKindOperator", {guifg = base16.colors.base0A},
                         false)
    vim.highlight.create("CmpItemKindColor", {guifg = base16.colors.base0A},
                         false)
    -- default
    vim.highlight.create("CmpItemKind", {guifg = base16.colors.base03}, false)
end

return M
