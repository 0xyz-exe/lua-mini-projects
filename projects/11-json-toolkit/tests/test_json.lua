#!/usr/bin/env lua
package.path = package.path .. ";../../../shared/test_helpers/?.lua;../src/?.lua"

local test = require("simple_test")
local json = require("json_toolkit")

print("Testing JSON Toolkit\n")

local data = {name = "Alice", age = 30, active = true}
local encoded, err = json.encode(data)
test.assert_not_nil(encoded, "encode data")
test.assert_true(encoded:find("Alice") ~= nil, "encoded contains name")

local decoded, err = json.decode(encoded)
test.assert_not_nil(decoded, "decode data")
test.assert_equal(decoded.name, "Alice", "decoded name")
test.assert_equal(decoded.age, 30, "decoded age")

-- Test validation
local schema = {
    type = "table",
    required = {"name", "age"}
}

local valid, err = json.validate(data, schema)
test.assert_true(valid, "valid data passes")

valid, err = json.validate({name = "Bob"}, schema)
test.assert_false(valid, "missing required field fails")
test.assert_not_nil(err, "error message provided")

-- Test file operations
local ok = json.save("../data/test.json", data)
test.assert_true(ok, "save to file")

local loaded, err = json.load("../data/test.json")
test.assert_not_nil(loaded, "load from file")
test.assert_equal(loaded.name, "Alice", "loaded data correct")

local success = test.summary()
os.exit(success and 0 or 1)
