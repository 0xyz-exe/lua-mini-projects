-- Coroutine Task Scheduler
local M = {}

function M.new_scheduler()
    return {
        tasks = {},
        current_id = 0
    }
end

function M.add_task(scheduler, func, name)
    scheduler.current_id = scheduler.current_id + 1
    local task = {
        id = scheduler.current_id,
        name = name or ("task_" .. scheduler.current_id),
        coroutine = coroutine.create(func),
        status = "ready"
    }
    table.insert(scheduler.tasks, task)
    return task.id
end

function M.step(scheduler)
    local completed = {}
    
    for i, task in ipairs(scheduler.tasks) do
        if task.status ~= "dead" then
            task.status = coroutine.status(task.coroutine)
            
            if task.status == "suspended" or task.status == "running" then
                local ok, err = coroutine.resume(task.coroutine)
                
                if not ok then
                    task.status = "error"
                    task.error = err
                else
                    task.status = coroutine.status(task.coroutine)
                end
            end
            
            if task.status == "dead" then
                table.insert(completed, i)
            end
        end
    end
    
    -- Remove completed tasks
    for i = #completed, 1, -1 do
        table.remove(scheduler.tasks, completed[i])
    end
    
    return #scheduler.tasks
end

function M.run(scheduler)
    while #scheduler.tasks > 0 do
        M.step(scheduler)
    end
end

return M
