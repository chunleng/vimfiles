local M = {
    models = {programmer = {model = 'gpt-4', temperature = 0.5, top_p = 1}},
    system_prompts = {
        programmer_code = "I want you to act as an expert programmer.\n\n" ..
            "Please avoid any commentary outside of the snippet response\n\n" ..
            "Start and end your answer with:\n\n```",
        programmer_chat = "I want you to act as an expert programmer."
    }
}

function M.setup()
    local gp = require("gp")
    gp.setup({command_prompt_prefix_template = "󱚤  {{agent}} ~"})

    local utils = require('common-utils')
    utils.keymap('n', '<c-space>', function()
        vim.ui.select({'Programmer: Complete Code'}, {}, function(choice)
            if choice == "Programmer: Complete Code" then
                local template = "Having following from {{filename}}:\n\n" ..
                                     "```{{filetype}}\n{{selection}}\n```\n\n" ..
                                     "Please reply with only the code added.\n\n" ..
                                     "Please continue the code with the following instruction: {{command}}"
                gp.Prompt({
                    range = 2,
                    line1 = 1,
                    line2 = vim.api.nvim_win_get_cursor(0)[1]
                }, gp.Target.append, gp.config.command_prompt_prefix_template,
                          M.models.programmer, template,
                          M.system_prompts.programmer_code)
            end
        end)
    end, {silent = false})
    utils.keymap('i', '<c-space>', function()
        vim.cmd("stopinsert")
        local template = "Having following from {{filename}}:\n\n" ..
                             "```{{filetype}}\n{{selection}}\n```\n\n" ..
                             "Please reply with only the code added.\n\n" ..
                             "Please continue the code with what you think comes after."
        gp.Prompt({
            range = 2,
            line1 = 1,
            line2 = vim.api.nvim_win_get_cursor(0)[1]
        }, gp.Target.append, nil, M.models.programmer, template,
                  M.system_prompts.programmer_code)

    end)
    utils.keymap('v', '<c-space>', function()
        vim.ui.select({
            'Programmer: Refine Code', 'Programmer: Summarize Code',
            'Programmer: Code Review', 'Programmer: Write Unit Test'
        }, {}, function(choice)
            local selection_range = {
                range = 2,
                line1 = vim.api.nvim_buf_get_mark(0, "<")[1],
                line2 = vim.api.nvim_buf_get_mark(0, ">")[1]
            }
            if choice == 'Programmer: Refine Code' then
                local template = "Having following from {{filename}}:\n\n" ..
                                     "```{{filetype}}\n{{selection}}\n```\n\n" ..
                                     "Please rewrite the code with the following instruction:\n\n{{command}}"
                gp.Prompt(selection_range, gp.Target.rewrite, "󱚤 ~",
                          M.models.programmer, template,
                          M.system_prompts.programmer_code)
            elseif choice == 'Programmer: Write Unit Test' then
                local template = "Having following from {{filename}}:\n\n" ..
                                     "```{{filetype}}\n{{selection}}\n```\n\n" ..
                                     "Please write unit test to test if the code is working"
                gp.Prompt(selection_range, gp.Target.enew, nil,
                          M.models.programmer, template,
                          M.system_prompts.programmer_code)
            elseif choice == 'Programmer: Summarize Code' then
                local template = "Having following from {{filename}}:\n\n" ..
                                     "```{{filetype}}\n{{selection}}\n```\n\n" ..
                                     "Please understand what the code is trying to do respond with a summary."
                gp.Prompt(selection_range, gp.Target.popup, nil,
                          M.models.programmer, template,
                          M.system_prompts.programmer_chat)
            elseif choice == 'Programmer: Code Review' then
                local template = "Having following from {{filename}}:\n\n" ..
                                     "```{{filetype}}\n{{selection}}\n```\n\n" ..
                                     "Please analyze for code smells and suggest improvements."
                gp.Prompt(selection_range, gp.Target.popup, nil,
                          M.models.programmer, template,
                          M.system_prompts.programmer_chat)
            end
        end)
    end)
end

return M
