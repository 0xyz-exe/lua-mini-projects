#!/usr/bin/env lua
-- Task Manager CLI

package.path = package.path .. ";../../../shared/utils/?.lua"
local json = require("json")
local task_module = require("task")

local DATA_FILE = "../data/tasks.json"

local function load_tasks()
    local tasks, err = json.load(DATA_FILE)
    if not tasks then
        return {}
    end
    return tasks
end

local function save_tasks(tasks)
    return json.save(DATA_FILE, tasks)
end

local function print_task(task, index)
    local status = task.completed and "[✓]" or "[ ]"
    local priority_sym = {low = "○", medium = "◐", high = "●"}
    print(string.format("%d. %s %s %s - %s", 
        index or 0, 
        status, 
        priority_sym[task.priority] or "○",
        task.title,
        task.due_date or "no deadline"))
end

local function add_command(tasks)
    io.write("Title: ")
    local title = io.read()
    
    io.write("Priority (low/medium/high) [medium]: ")
    local priority = io.read()
    if priority == "" then priority = "medium" end
    
    io.write("Due date (optional): ")
    local due_date = io.read()
    if due_date == "" then due_date = nil end
    
    local task, err = task_module.new_task(title, priority, due_date)
    if not task then
        print("Error: " .. err)
        return
    end
    
    task_module.add_task(tasks, task)
    save_tasks(tasks)
    print("Task added!")
end

local function list_command(tasks, filter)
    local results = task_module.find_tasks(tasks, filter or {})
    if #results == 0 then
        print("No tasks found")
        return
    end
    
    for i, task in ipairs(results) do
        print_task(task, i)
    end
    print(string.format("\nTotal: %d tasks", #results))
end

local function complete_command(tasks)
    list_command(tasks, {status = "pending"})
    io.write("\nTask number to complete: ")
    local num = tonumber(io.read())
    
    if not num or num < 1 or num > #tasks then
        print("Invalid task number")
        return
    end
    
    local pending = task_module.find_tasks(tasks, {status = "pending"})
    task_module.complete_task(tasks, pending[num].id)
    save_tasks(tasks)
    print("Task completed!")
end

local function delete_command(tasks)
    list_command(tasks)
    io.write("\nTask number to delete: ")
    local num = tonumber(io.read())
    
    if not num or num < 1 or num > #tasks then
        print("Invalid task number")
        return
    end
    
    task_module.delete_task(tasks, tasks[num].id)
    save_tasks(tasks)
    print("Task deleted!")
end

-- Main loop
local tasks = load_tasks()

while true do
    print("\n=== Task Manager ===")
    print("1. Add task")
    print("2. List all tasks")
    print("3. List pending tasks")
    print("4. Complete task")
    print("5. Delete task")
    print("6. Search tasks")
    print("7. Exit")
    io.write("\nChoice: ")
    
    local choice = io.read()
    
    if choice == "1" then
        add_command(tasks)
    elseif choice == "2" then
        list_command(tasks)
    elseif choice == "3" then
        list_command(tasks, {status = "pending"})
    elseif choice == "4" then
        complete_command(tasks)
    elseif choice == "5" then
        delete_command(tasks)
    elseif choice == "6" then
        io.write("Search query: ")
        local query = io.read()
        list_command(tasks, {query = query})
    elseif choice == "7" then
        print("Goodbye!")
        break
    else
        print("Invalid choice")
    end
end
