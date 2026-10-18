#!/usr/bin/env lua
package.path = package.path .. ";../../../shared/test_helpers/?.lua;../src/?.lua"

local test = require("simple_test")
local calc = require("calculator")

print("Testing Calculator Module\n")

-- Addition tests
test.assert_equal(calc.add(5, 3), 8, "5 + 3 = 8")
test.assert_equal(calc.add(-5, 3), -2, "-5 + 3 = -2")
test.assert_equal(calc.add(0, 0), 0, "0 + 0 = 0")

-- Subtraction tests
test.assert_equal(calc.subtract(10, 3), 7, "10 - 3 = 7")
test.assert_equal(calc.subtract(3, 10), -7, "3 - 10 = -7")

-- Multiplication tests
test.assert_equal(calc.multiply(4, 5), 20, "4 * 5 = 20")
test.assert_equal(calc.multiply(-4, 5), -20, "-4 * 5 = -20")
test.assert_equal(calc.multiply(0, 100), 0, "0 * 100 = 0")

-- Division tests
test.assert_equal(calc.divide(20, 4), 5, "20 / 4 = 5")
test.assert_equal(calc.divide(10, 3), 10/3, "10 / 3 = 3.333...")

local result, err = calc.divide(5, 0)
test.assert_nil(result, "divide by zero returns nil")
test.assert_equal(err, "division by zero", "divide by zero error message")

-- Modulo tests
test.assert_equal(calc.modulo(10, 3), 1, "10 % 3 = 1")
test.assert_equal(calc.modulo(20, 5), 0, "20 % 5 = 0")

result, err = calc.modulo(5, 0)
test.assert_nil(result, "modulo by zero returns nil")

-- Power tests
test.assert_equal(calc.power(2, 3), 8, "2 ^ 3 = 8")
test.assert_equal(calc.power(5, 0), 1, "5 ^ 0 = 1")

-- Calculate function tests
test.assert_equal(calc.calculate("+", 5, 3), 8, "calculate with +")
test.assert_equal(calc.calculate("*", 4, 5), 20, "calculate with *")

result, err = calc.calculate("?", 1, 2)
test.assert_nil(result, "unknown operation returns nil")
test.assert_equal(err, "unknown operation", "unknown operation error")

local success = test.summary()
os.exit(success and 0 or 1)
