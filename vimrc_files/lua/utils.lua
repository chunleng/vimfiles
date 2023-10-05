local M = {}

function M.snake_to_upper_camel(str)
    local words = vim.split(str, '_', {plain = true})
    return table.concat(M.title_case(words), '')
end

function M.lower_to_upper_camel(str) return
    table.concat(M.title_case({str}), '') end

function M.title_case(arr)
    for i = 1, #arr do arr[i] = arr[i]:gsub("^%l", string.upper) end
    return arr
end

return M
