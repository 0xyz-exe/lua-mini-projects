#!/usr/bin/env lua
package.path = package.path .. ";../../../shared/test_helpers/?.lua;../src/?.lua"

local test = require("simple_test")
local expense = require("expense")

print("Testing Expense Tracker\n")

local rec, err = expense.new_record(100, "food", "Lunch")
test.assert_not_nil(rec, "create expense")
test.assert_equal(rec.amount, 100, "amount set")
test.assert_equal(rec.category, "food", "category set")

rec, err = expense.new_record(0, "food")
test.assert_nil(rec, "zero amount rejected")

rec, err = expense.new_record(50, "")
test.assert_nil(rec, "empty category rejected")

local records = {}
table.insert(records, expense.new_record(1000, "salary", "Monthly", "income"))
table.insert(records, expense.new_record(200, "food", "Groceries", "expense"))
table.insert(records, expense.new_record(100, "transport", "Gas", "expense"))

local year, month = tonumber(os.date("%Y")), tonumber(os.date("%m"))
local summary = expense.get_monthly_summary(records, year, month)
test.assert_equal(summary.income, 1000, "income total")
test.assert_equal(summary.expense, 300, "expense total")
test.assert_equal(summary.balance, 700, "balance correct")
test.assert_equal(summary.by_category.food, 200, "food category")

local ok = expense.export_csv(records, "../data/test_export.csv")
test.assert_true(ok, "csv export success")

local success = test.summary()
os.exit(success and 0 or 1)
