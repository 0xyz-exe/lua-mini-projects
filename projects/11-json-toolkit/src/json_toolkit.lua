-- JSON Toolkit Module (enhanced version of shared/utils/json.lua)
local M = {}

function M.validate(data, schema)
    if schema.type then
        if type(data) ~= schema.type then
            return false, "type mismatch: expected " .. schema.type
        end
    end
    
    if schema.type == "table" and schema.required then
        for _, field in ipairs(schema.required) do
            if data[field] == nil then
                return false, "missing required field: " .. field
            end
        end
    end
    
    return true
end

-- Reuse encode/decode from shared
package.path = package.path .. ";../../../shared/utils/?.lua"
local json_base = require("json")

M.encode = json_base.encode
M.decode = json_base.decode
M.save = json_base.save
M.load = json_base.load

return M
