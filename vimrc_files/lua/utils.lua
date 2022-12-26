local M = {}

function M.snake_to_upper_camel(str)
    local ret = {}
    for _, value in ipairs(vim.split(str, '_', {plain = true})) do
        table.insert(ret, (value:gsub("^%l", string.upper)))
    end
    return table.concat(ret, '')
end

return M
