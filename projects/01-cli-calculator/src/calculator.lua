-- CLI Calculator Module
local M = {}

function M.add(a, b)
    return a + b
end

function M.subtract(a, b)
    return a - b
end

function M.multiply(a, b)
    return a * b
end

function M.divide(a, b)
    if b == 0 then
        return nil, "division by zero"
    end
    return a / b
end

function M.modulo(a, b)
    if b == 0 then
        return nil, "modulo by zero"
    end
    return a % b
end

function M.power(a, b)
    return a ^ b
end

function M.calculate(operation, a, b)
    local ops = {
        ["+"] = M.add,
        ["-"] = M.subtract,
        ["*"] = M.multiply,
        ["/"] = M.divide,
        ["%"] = M.modulo,
        ["^"] = M.power,
    }
    
    local func = ops[operation]
    if not func then
        return nil, "unknown operation"
    end
    
    return func(a, b)
end

return M
