-- Local Search Engine
local M = {}

function M.new_index()
    return {
        documents = {},
        inverted_index = {},
        doc_count = 0
    }
end

function M.tokenize(text)
    local tokens = {}
    for word in text:lower():gmatch("%w+") do
        table.insert(tokens, word)
    end
    return tokens
end

function M.add_document(index, doc_id, content, metadata)
    if index.documents[doc_id] then
        return false, "document already indexed"
    end
    
    local tokens = M.tokenize(content)
    
    index.documents[doc_id] = {
        content = content,
        tokens = tokens,
        metadata = metadata or {}
    }
    
    for _, token in ipairs(tokens) do
        if not index.inverted_index[token] then
            index.inverted_index[token] = {}
        end
        index.inverted_index[token][doc_id] = (index.inverted_index[token][doc_id] or 0) + 1
    end
    
    index.doc_count = index.doc_count + 1
    return true
end

function M.search(index, query, limit)
    local tokens = M.tokenize(query)
    local scores = {}
    
    for _, token in ipairs(tokens) do
        if index.inverted_index[token] then
            for doc_id, count in pairs(index.inverted_index[token]) do
                scores[doc_id] = (scores[doc_id] or 0) + count
            end
        end
    end
    
    local results = {}
    for doc_id, score in pairs(scores) do
        table.insert(results, {
            doc_id = doc_id,
            score = score,
            content = index.documents[doc_id].content
        })
    end
    
    table.sort(results, function(a, b) return a.score > b.score end)
    
    if limit and limit < #results then
        local limited = {}
        for i = 1, limit do
            table.insert(limited, results[i])
        end
        return limited
    end
    
    return results
end

return M
