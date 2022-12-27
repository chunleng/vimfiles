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
                vim.fn.eval([[feedkeys("\<end>", "n")]])
            end,
            ['<c-a>'] = function()
                vim.fn.eval([[feedkeys("\<c-o>I", "n")]])
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

    local theme = require('common-theme')
    theme.set_hl("CmpItemAbbrMatch", {fg = 12})
    theme.set_hl('CmpItemAbbrMatchFuzzy', {fg = 12})
    theme.set_hl('CmpItemAbbrDeprecatedDefault',
                 {strikethrough = true, fg = theme.blender.fg_darker_3})
    theme.set_hl('CmpItemMenu', {italic = true, fg = theme.blender.fg_lighter_2})
    theme.set_hl('CmpItemKind', {fg = 12})
end

return M
