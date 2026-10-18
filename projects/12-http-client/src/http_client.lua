-- HTTP Client Module (mock/stub - no external dependencies)
-- ponytail: Real HTTP needs luasocket/curl. This provides interface only.
local M = {}

function M.request(url, options)
    options = options or {}
    
    -- Stub implementation for testing
    if url:find("mock://") then
        return {
            status = 200,
            body = '{"message": "mock response"}',
            headers = {["content-type"] = "application/json"}
        }
    end
    
    return nil, "HTTP not available. Install luasocket or curl."
end

function M.get(url, options)
    options = options or {}
    options.method = "GET"
    return M.request(url, options)
end

function M.post(url, body, options)
    options = options or {}
    options.method = "POST"
    options.body = body
    return M.request(url, options)
end

function M.parse_json_response(response)
    if not response then
        return nil, "no response"
    end
    
    package.path = package.path .. ";../../../shared/utils/?.lua"
    local json = require("json")
    
    return json.decode(response.body)
end

return M
