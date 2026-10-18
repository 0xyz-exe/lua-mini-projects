#!/usr/bin/env lua
package.path = package.path .. ";../../../shared/test_helpers/?.lua;../src/?.lua"

local test = require("simple_test")
local eb = require("event_bus")

print("Testing Event Bus\n")

local bus = eb.new_bus()
test.assert_not_nil(bus, "create event bus")

local called = false
local handler = function(data)
    called = true
end

eb.on(bus, "test_event", handler)
local count = eb.emit(bus, "test_event", {})
test.assert_true(called, "handler called")
test.assert_equal(count, 1, "one handler executed")

called = false
eb.off(bus, "test_event", handler)
eb.emit(bus, "test_event", {})
test.assert_false(called, "handler removed")

-- Test multiple handlers
local counter = 0
eb.on(bus, "count", function() counter = counter + 1 end)
eb.on(bus, "count", function() counter = counter + 10 end)
eb.emit(bus, "count")
test.assert_equal(counter, 11, "multiple handlers executed")

-- Test error handling
local error_handler = function() error("handler error") end
eb.on(bus, "error_event", error_handler)
count = eb.emit(bus, "error_event")
test.assert_equal(count, 0, "error handler did not count")

-- Test plugin
local plugin_called = false
local plugin = {
    init = function(bus)
        eb.on(bus, "plugin_event", function() plugin_called = true end)
    end
}
eb.register_plugin(bus, plugin)
eb.emit(bus, "plugin_event")
test.assert_true(plugin_called, "plugin registered and called")

local success = test.summary()
os.exit(success and 0 or 1)
