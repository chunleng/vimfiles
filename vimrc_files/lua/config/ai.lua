local RangeType = {SELECTION = 0, ALL_BEFORE = 1}
local gp = require("gp")
local M = {
    models = {programmer = {model = 'gpt-4', temperature = 0.5, top_p = 1}},
    system_prompts = {
        programmer_code = "I want you to act as an expert programmer.\n\n" ..
            "Please avoid any commentary outside of the snippet response\n\n" ..
            "Start and end your answer with:\n\n```",
        programmer_chat = "I want you to act as an expert programmer."
    }
}

local function send(template, table)
    local range = nil
    if table.range_type == RangeType.ALL_BEFORE then
        local current_line = vim.api.nvim_win_get_cursor(0)[1]
        range = current_line == 1 and {} or
                    {range = 2, line1 = 1, line2 = current_line}
    else
        range = {
            range = 2,
            line1 = vim.api.nvim_buf_get_mark(0, "<")[1],
            line2 = vim.api.nvim_buf_get_mark(0, ">")[1]
        }
    end
    local target = table.target or gp.Target.append
    local prompt_text = table.has_prompt and "󱚤  ~" or nil
    local model = table.model or M.models.programmer
    local system_prompt = table.system_prompt or
                              M.system_prompts.programmer_code
    gp.Prompt(range, target, prompt_text, model, template, system_prompt)
end

function M.setup()
    gp.setup({command_prompt_prefix_template = "󱚤  {{agent}} ~"})

    local utils = require('common-utils')
    utils.keymap('n', '<c-space>', function()
        vim.ui.select({'Programmer: Complete Code'}, {}, function(choice)
            if choice == "Programmer: Complete Code" then
                send("Having following from {{filename}}:\n\n" ..
                         "```{{filetype}}\n{{selection}}\n```\n\n" ..
                         "Please reply with only the code added.\n\n" ..
                         "Please continue the code with the following instruction: {{command}}",
                     {has_prompt = true, range_type = RangeType.ALL_BEFORE})
            end
        end)
    end, {silent = false})
    utils.keymap('v', '<c-space>', function()
        vim.ui.select({
            'Programmer: Refine Code', 'Programmer: Summarize Code',
            'Programmer: Code Review', 'Programmer: Write Unit Test'
        }, {}, function(choice)
            if choice == 'Programmer: Refine Code' then
                send("Having following from {{filename}}:\n\n" ..
                         "```{{filetype}}\n{{selection}}\n```\n\n" ..
                         "Please rewrite the code with the following instruction:\n\n{{command}}",
                     {has_prompt = true, target = gp.Target.rewrite})
            elseif choice == 'Programmer: Write Unit Test' then
                send("Having following from {{filename}}:\n\n" ..
                         "```{{filetype}}\n{{selection}}\n```\n\n" ..
                         "Please write unit test to test if the code is working",
                     {target = gp.Target.enew})
            elseif choice == 'Programmer: Summarize Code' then
                send("Having following from {{filename}}:\n\n" ..
                         "```{{filetype}}\n{{selection}}\n```\n\n" ..
                         "Please understand what the code is trying to do and " ..
                         "respond with a summary the core logic in steps but as short as possible.\n\n" ..
                         "It's okay to drop steps which are not relevant to understand the logic",
                     {
                    target = gp.Target.popup,
                    system_prompt = M.system_prompts.programmer_chat
                })
            elseif choice == 'Programmer: Code Review' then
                send("Having following from {{filename}}:\n\n" ..
                         "```{{filetype}}\n{{selection}}\n```\n\n" ..
                         "Please analyze for code smells and suggest improvements.",
                     {
                    target = gp.Target.popup,
                    system_prompt = M.system_prompts.programmer_chat
                })
            end
        end)
    end)
end

return M
