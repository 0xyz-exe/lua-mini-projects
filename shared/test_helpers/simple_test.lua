-- Simple test framework for Lua projects
local M = {}

local total_tests = 0
local passed_tests = 0
local failed_tests = 0

function M.assert_equal(actual, expected, message)
    total_tests = total_tests + 1
    if actual == expected then
        passed_tests = passed_tests + 1
        io.write(".")
        return true
    else
        failed_tests = failed_tests + 1
        print(string.format("\n✗ FAIL: %s\n  Expected: %s\n  Got: %s", 
            message or "assertion failed", tostring(expected), tostring(actual)))
        return false
    end
end

function M.assert_true(condition, message)
    return M.assert_equal(condition, true, message)
end

function M.assert_false(condition, message)
    return M.assert_equal(condition, false, message)
end

function M.assert_nil(value, message)
    return M.assert_equal(value, nil, message)
end

function M.assert_not_nil(value, message)
    total_tests = total_tests + 1
    if value ~= nil then
        passed_tests = passed_tests + 1
        io.write(".")
        return true
    else
        failed_tests = failed_tests + 1
        print(string.format("\n✗ FAIL: %s", message or "expected non-nil value"))
        return false
    end
end

function M.summary()
    print(string.format("\n\nTests: %d | Passed: %d | Failed: %d", 
        total_tests, passed_tests, failed_tests))
    return failed_tests == 0
end

function M.reset()
    total_tests = 0
    passed_tests = 0
    failed_tests = 0
end

return M
