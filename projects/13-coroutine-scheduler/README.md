# Project 13: Coroutine Scheduler

Cooperative task scheduler using Lua coroutines.

## Features

- Add/remove tasks
- Step execution
- Error handling
- Task status tracking

## Usage

```lua
local sched = require("scheduler")
local scheduler = sched.new_scheduler()

sched.add_task(scheduler, function()
    for i = 1, 10 do
        print("Task running:", i)
        coroutine.yield()
    end
end)

sched.run(scheduler)
```

## Testing

```bash
cd projects/13-coroutine-scheduler/tests
lua test_scheduler.lua
```

## Note

Lua coroutines are cooperative, not preemptive threads.
