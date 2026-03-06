vim.api.nvim_create_autocmd("FileType", {
	pattern = "codecompanion",
	callback = function()
		-- Temporarily shadow vim.bo.filetype so nvim-autopairs' on_attach
		-- loads the rules registered for "markdown" into this buffer.
		local autopairs = require("nvim-autopairs")

		-- Get all rules that apply to "markdown"
		local markdown_rules = {}
		for _, rule in pairs(autopairs.config.rules) do
			local utils = require("nvim-autopairs.utils")
			if
				utils.check_filetype(rule.filetypes, "markdown")
				and utils.check_not_filetype(rule.not_filetypes, "markdown")
			then
				table.insert(markdown_rules, rule)
			end
		end

		-- Add "codecompanion" to each of those rules' filetypes
		for _, rule in ipairs(markdown_rules) do
			if rule.filetypes then
				-- Only add if not already present
				local already = false
				for _, ft in ipairs(rule.filetypes) do
					if ft == "codecompanion" then
						already = true
						break
					end
				end
				if not already then
					table.insert(rule.filetypes, "codecompanion")
				end
			end
			-- rules with filetypes == nil already apply to all filetypes, skip
		end

		-- Re-run attach so the buffer picks up the updated rules
		autopairs.force_attach()
	end,
})

return {}
