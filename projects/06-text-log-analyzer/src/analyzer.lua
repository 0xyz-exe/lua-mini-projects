-- Text and Log Analyzer Module
local M = {}

function M.analyze_text(content)
    local lines = 0
    local words = 0
    local chars = #content
    
    for line in content:gmatch("[^\r\n]+") do
        lines = lines + 1
        for word in line:gmatch("%S+") do
            words = words + 1
        end
    end
    
    return {lines = lines, words = words, chars = chars}
end

function M.word_frequency(content, limit)
    local freq = {}
    for word in content:lower():gmatch("%w+") do
        freq[word] = (freq[word] or 0) + 1
    end
    
    local sorted = {}
    for word, count in pairs(freq) do
        table.insert(sorted, {word = word, count = count})
    end
    
    table.sort(sorted, function(a, b) return a.count > b.count end)
    
    if limit then
        local result = {}
        for i = 1, math.min(limit, #sorted) do
            table.insert(result, sorted[i])
        end
        return result
    end
    
    return sorted
end

function M.search_lines(content, pattern)
    local results = {}
    local line_num = 1
    for line in content:gmatch("[^\r\n]+") do
        if line:find(pattern) then
            table.insert(results, {line_num = line_num, text = line})
        end
        line_num = line_num + 1
    end
    return results
end

return M
