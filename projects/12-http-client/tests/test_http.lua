#!/usr/bin/env lua
package.path = package.path .. ";../../../shared/test_helpers/?.lua;../src/?.lua"

local test = require("simple_test")
local http = require("http_client")

print("Testing HTTP Client (mock)\n")

local response, err = http.get("mock://example.com/api")
test.assert_not_nil(response, "mock GET request")
test.assert_equal(response.status, 200, "status 200")
test.assert_not_nil(response.body, "response has body")

local data = http.parse_json_response(response)
test.assert_not_nil(data, "parse JSON response")
if data then
    test.assert_equal(data.message, "mock response", "parsed message")
end

response = http.post("mock://api/data", '{"test": true}')
test.assert_not_nil(response, "mock POST request")

-- Test real URL without socket (should fail gracefully)
response, err = http.get("https://example.com")
test.assert_nil(response, "real HTTP returns nil without library")
test.assert_not_nil(err, "error message provided")

local success = test.summary()
os.exit(success and 0 or 1)
