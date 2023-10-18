local M = {}

function M.setup()
    local gp = require("gp")
    gp.setup({command_prompt_prefix = "󱚤 "})

    local utils = require('common-utils')
    utils.keymap('n', '<c-space>', function()
        vim.ui.select({'Prompt', 'Summarize Code', 'Code Review'}, {},
                      function(choice)
            if choice == "Prompt" then
                local template = gp.config.template_rewrite
                gp.Prompt({
                    range = 2,
                    line1 = 1,
                    line2 = vim.api.nvim_win_get_cursor(0)[1]
                }, gp.Target.append, gp.config.command_prompt_prefix,
                          gp.config.command_model, template,
                          gp.config.command_system_prompt)
            end
        end)
    end, {silent = false})
    utils.keymap('i', '<c-space>', function()
        vim.cmd("stopinsert")
        local template = "I have the following code from {{filename}}:\n\n" ..
                             "```{{filetype}}\n{{selection}}\n```\n\n" ..
                             "Please respond by giving the relevant code that should come next. " ..
                             "Please only respond with the snippet of code that should be inserted. " ..
                             "Please truncate your answer if it's more than 10 characters"
        gp.Prompt({
            range = 2,
            line1 = 1,
            line2 = vim.api.nvim_win_get_cursor(0)[1]
        }, gp.Target.append, nil, gp.config.command_model, template,
                  gp.config.command_system_prompt)

    end)
    utils.keymap('v', '<c-space>', function()
        vim.ui.select({'Prompt', 'Summarize Code', 'Code Review'}, {},
                      function(choice)
            local selection_range = {
                range = 2,
                line1 = vim.api.nvim_buf_get_mark(0, "<")[1],
                line2 = vim.api.nvim_buf_get_mark(0, ">")[1]
            }
            if choice == 'Prompt' then
                local template = gp.config.template_rewrite
                gp.Prompt(selection_range, gp.Target.rewrite,
                          gp.config.command_prompt_prefix,
                          gp.config.command_model, template,
                          gp.config.command_system_prompt)
            elseif choice == 'Summarize Code' then
                local template =
                    "I have the following code from {{filename}}:\n\n" ..
                        "```{{filetype}}\n{{selection}}\n```\n\n" ..
                        "Please respond by summarizing the code above."
                gp.Prompt(selection_range, gp.Target.popup, nil,
                          gp.config.command_model, template,
                          "You are a professional programmer")
            elseif choice == 'Code Review' then
                local template =
                    "I have the following code from {{filename}}:\n\n" ..
                        "```{{filetype}}\n{{selection}}\n```\n\n" ..
                        "Please analyze for code smells and suggest improvements."
                gp.Prompt(selection_range, gp.Target.popup, nil,
                          gp.config.command_model, template,
                          "You are a professional programmer")
            end
        end)
    end)
end

return M
