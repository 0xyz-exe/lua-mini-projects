# Project 14: Event Bus & Plugin System

Event-driven architecture with pub/sub pattern.

## Features

- Register/remove handlers
- Emit events
- Multiple subscribers
- Error isolation
- Plugin system

## Usage

```lua
local eb = require("event_bus")
local bus = eb.new_bus()

eb.on(bus, "user_login", function(data)
    print("User logged in:", data.username)
end)

eb.emit(bus, "user_login", {username = "alice"})
```

## Testing

```bash
cd projects/14-event-bus/tests
lua test_event_bus.lua
```
