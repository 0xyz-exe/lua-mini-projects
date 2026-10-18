-- Expense Tracker Module
local M = {}

function M.new_record(amount, category, description, type)
    if not amount or amount <= 0 then
        return nil, "invalid amount"
    end
    if not category or category == "" then
        return nil, "category required"
    end
    
    return {
        id = os.time() .. math.random(1000, 9999),
        amount = amount,
        category = category,
        description = description or "",
        type = type or "expense",
        date = os.date("%Y-%m-%d"),
        timestamp = os.time()
    }
end

function M.get_monthly_summary(records, year, month)
    local total_income = 0
    local total_expense = 0
    local by_category = {}
    
    for _, record in ipairs(records) do
        local y, m = record.date:match("^(%d+)-(%d+)")
        if tonumber(y) == year and tonumber(m) == month then
            if record.type == "income" then
                total_income = total_income + record.amount
            else
                total_expense = total_expense + record.amount
                by_category[record.category] = (by_category[record.category] or 0) + record.amount
            end
        end
    end
    
    return {
        income = total_income,
        expense = total_expense,
        balance = total_income - total_expense,
        by_category = by_category
    }
end

function M.export_csv(records, filename)
    local file = io.open(filename, "w")
    if not file then
        return false, "cannot open file"
    end
    
    file:write("Date,Type,Category,Amount,Description\n")
    for _, record in ipairs(records) do
        file:write(string.format('%s,%s,%s,%.2f,"%s"\n',
            record.date, record.type, record.category, record.amount, record.description))
    end
    file:close()
    return true
end

return M
