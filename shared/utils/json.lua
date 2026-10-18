-- JSON Module (Pure Lua implementation)
-- ponytail: No validation, no streaming. Add schema validation when needed.
local M = {}

local function escape_string(s)
    s = s:gsub("\\", "\\\\")
    s = s:gsub('"', '\\"')
    s = s:gsub("\n", "\\n")
    s = s:gsub("\r", "\\r")
    s = s:gsub("\t", "\\t")
    return s
end

local function encode_value(val)
    local t = type(val)
    if t == "string" then
        return '"' .. escape_string(val) .. '"'
    elseif t == "number" then
        return tostring(val)
    elseif t == "boolean" then
        return tostring(val)
    elseif t == "nil" then
        return "null"
    elseif t == "table" then
        local is_array = #val > 0
        if is_array then
            local items = {}
            for i = 1, #val do
                table.insert(items, encode_value(val[i]))
            end
            return "[" .. table.concat(items, ",") .. "]"
        else
            local items = {}
            for k, v in pairs(val) do
                table.insert(items, '"' .. escape_string(tostring(k)) .. '":' .. encode_value(v))
            end
            return "{" .. table.concat(items, ",") .. "}"
        end
    else
        error("unsupported type: " .. t)
    end
end

function M.encode(data)
    local ok, result = pcall(encode_value, data)
    if ok then
        return result, nil
    else
        return nil, result
    end
end

function M.decode(json_str)
    if not json_str or json_str == "" then
        return nil, "empty input"
    end
    
    -- Simple JSON to Lua table parser
    local result = {}
    
    -- Match all key-value pairs in object
    for key, value in json_str:gmatch('"([^"]+)"%s*:%s*([^,}]+)') do
        value = value:gsub("%s+$", "")  -- Trim trailing whitespace
        
        if value == "null" then
            result[key] = nil
        elseif value == "true" then
            result[key] = true
        elseif value == "false" then
            result[key] = false
        elseif value:match('^"') then
            result[key] = value:match('^"(.-)"')  -- Extract quoted string
        else
            result[key] = tonumber(value)
        end
    end
    
    if next(result) then
        return result
    end
    
    return nil, "parse error"
end

function M.save(filename, data)
    local json, err = M.encode(data)
    if not json then
        return false, err
    end
    
    local file, err = io.open(filename, "w")
    if not file then
        return false, err
    end
    
    file:write(json)
    file:close()
    return true
end

function M.load(filename)
    local file, err = io.open(filename, "r")
    if not file then
        return nil, err
    end
    
    local content = file:read("*a")
    file:close()
    
    return M.decode(content)
end

return M
