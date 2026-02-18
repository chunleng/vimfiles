local M = {}
local codecompanion = require("codecompanion")

function M.rename_chat(bufnr)
	vim.ui.input({ prompt = "Rename chat title:" }, function(x)
		codecompanion.buf_get_chat(bufnr):set_title(x)
	end)
end

return M
