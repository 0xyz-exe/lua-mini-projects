-- Task Manager Module
local M = {}

function M.new_task(title, priority, due_date)
    if not title or title == "" then
        return nil, "title required"
    end
    
    return {
        id = os.time() .. math.random(1000, 9999),
        title = title,
        priority = priority or "medium",
        due_date = due_date,
        completed = false,
        created_at = os.time()
    }
end

function M.add_task(tasks, task)
    table.insert(tasks, task)
    return task
end

function M.complete_task(tasks, id)
    for i, task in ipairs(tasks) do
        if task.id == id then
            task.completed = true
            return true
        end
    end
    return false, "task not found"
end

function M.delete_task(tasks, id)
    for i, task in ipairs(tasks) do
        if task.id == id then
            table.remove(tasks, i)
            return true
        end
    end
    return false, "task not found"
end

function M.find_tasks(tasks, filter)
    local results = {}
    for _, task in ipairs(tasks) do
        local match = true
        
        if filter.status then
            if filter.status == "completed" and not task.completed then
                match = false
            elseif filter.status == "pending" and task.completed then
                match = false
            end
        end
        
        if filter.priority and task.priority ~= filter.priority then
            match = false
        end
        
        if filter.query then
            if not task.title:lower():find(filter.query:lower(), 1, true) then
                match = false
            end
        end
        
        if match then
            table.insert(results, task)
        end
    end
    return results
end

return M
