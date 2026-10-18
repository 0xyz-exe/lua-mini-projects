#!/usr/bin/env lua
package.path = package.path .. ";../../../shared/test_helpers/?.lua;../src/?.lua"

local test = require("simple_test")
local sched = require("scheduler")

print("Testing Coroutine Scheduler\n")

local scheduler = sched.new_scheduler()
test.assert_not_nil(scheduler, "create scheduler")

local counter = 0
local task1 = function()
    for i = 1, 3 do
        counter = counter + 1
        coroutine.yield()
    end
end

local task2 = function()
    for i = 1, 2 do
        counter = counter + 10
        coroutine.yield()
    end
end

local id1 = sched.add_task(scheduler, task1, "counter1")
local id2 = sched.add_task(scheduler, task2, "counter10")
test.assert_equal(#scheduler.tasks, 2, "two tasks added")

sched.step(scheduler)
test.assert_true(counter > 0, "tasks executed")

sched.run(scheduler)
test.assert_equal(#scheduler.tasks, 0, "all tasks completed")
test.assert_equal(counter, 23, "counter = 1+1+1+10+10 = 23")

-- Test error handling
scheduler = sched.new_scheduler()
local error_task = function()
    error("task error")
end
sched.add_task(scheduler, error_task)
sched.step(scheduler)
test.assert_equal(scheduler.tasks[1].status, "error", "error captured")

local success = test.summary()
os.exit(success and 0 or 1)
