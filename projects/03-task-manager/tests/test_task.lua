#!/usr/bin/env lua
package.path = package.path .. ";../../../shared/test_helpers/?.lua;../src/?.lua"

local test = require("simple_test")
local task_module = require("task")

print("Testing Task Manager\n")

-- Test task creation
local task, err = task_module.new_task("Test task", "high", "2026-12-31")
test.assert_not_nil(task, "create task")
test.assert_equal(task.title, "Test task", "task title")
test.assert_equal(task.priority, "high", "task priority")
test.assert_false(task.completed, "task not completed initially")

task, err = task_module.new_task(nil)
test.assert_nil(task, "empty title rejected")

-- Test adding tasks
local tasks = {}
local t1 = task_module.new_task("Task 1", "low")
local t2 = task_module.new_task("Task 2", "high")
task_module.add_task(tasks, t1)
task_module.add_task(tasks, t2)
test.assert_equal(#tasks, 2, "two tasks added")

-- Test completing tasks
local ok = task_module.complete_task(tasks, t1.id)
test.assert_true(ok, "complete task success")
test.assert_true(t1.completed, "task marked completed")

ok, err = task_module.complete_task(tasks, "nonexistent")
test.assert_false(ok, "complete nonexistent task fails")

-- Test deleting tasks
ok = task_module.delete_task(tasks, t2.id)
test.assert_true(ok, "delete task success")
test.assert_equal(#tasks, 1, "one task remaining")

-- Test filtering
tasks = {}
task_module.add_task(tasks, task_module.new_task("Buy milk", "high"))
task_module.add_task(tasks, task_module.new_task("Buy bread", "low"))
task_module.add_task(tasks, task_module.new_task("Clean room", "medium"))
tasks[1].completed = true

local results = task_module.find_tasks(tasks, {status = "pending"})
test.assert_equal(#results, 2, "find pending tasks")

results = task_module.find_tasks(tasks, {priority = "high"})
test.assert_equal(#results, 1, "find high priority")

results = task_module.find_tasks(tasks, {query = "buy"})
test.assert_equal(#results, 2, "search query")

local success = test.summary()
os.exit(success and 0 or 1)
