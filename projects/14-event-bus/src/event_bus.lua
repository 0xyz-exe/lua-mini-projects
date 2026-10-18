-- Event Bus and Plugin System
local M = {}

function M.new_bus()
    return {
        listeners = {},
        plugins = {}
    }
end

function M.on(bus, event, handler)
    if not bus.listeners[event] then
        bus.listeners[event] = {}
    end
    table.insert(bus.listeners[event], handler)
end

function M.off(bus, event, handler)
    if not bus.listeners[event] then return end
    
    for i, h in ipairs(bus.listeners[event]) do
        if h == handler then
            table.remove(bus.listeners[event], i)
            return true
        end
    end
    return false
end

function M.emit(bus, event, data)
    if not bus.listeners[event] then return 0 end
    
    local count = 0
    for _, handler in ipairs(bus.listeners[event]) do
        local ok, err = pcall(handler, data)
        if ok then
            count = count + 1
        else
            -- ponytail: Log errors to stderr. Add proper logger when needed.
            io.stderr:write("Event handler error: " .. tostring(err) .. "\n")
        end
    end
    return count
end

function M.register_plugin(bus, plugin)
    if plugin.init then
        plugin.init(bus)
    end
    table.insert(bus.plugins, plugin)
end

return M
