#!/usr/bin/env lua
package.path = package.path .. ";../../../shared/test_helpers/?.lua;../src/?.lua"

local test = require("simple_test")
local inv = require("inventory")

print("Testing Inventory System\n")

local inventory = inv.new_inventory(5)
test.assert_not_nil(inventory, "create inventory")
test.assert_equal(inventory.capacity, 5, "capacity set")

local ok = inv.add_item(inventory, "wood", 10)
test.assert_true(ok, "add stackable item")
test.assert_equal(inventory.size, 10, "size updated")

ok = inv.add_item(inventory, "wood", 5)
test.assert_true(ok, "stack existing item")
test.assert_equal(#inventory.items, 1, "items stacked")
test.assert_equal(inventory.items[1].quantity, 15, "quantity increased")

ok = inv.remove_item(inventory, "wood", 5)
test.assert_true(ok, "remove item")
test.assert_equal(inventory.items[1].quantity, 10, "quantity decreased")

ok, err = inv.remove_item(inventory, "wood", 20)
test.assert_false(ok, "cannot remove more than available")

-- Test crafting
inventory = inv.new_inventory(10)
inv.add_item(inventory, "wood", 4)
inv.add_item(inventory, "stone", 2)

local recipe = {
    requires = {wood = 4, stone = 2},
    produces = "sword",
    quantity = 1
}

ok = inv.craft(inventory, recipe)
test.assert_true(ok, "craft with valid ingredients")

local has_sword = false
for _, item in ipairs(inventory.items) do
    if item.id == "sword" then
        has_sword = true
        break
    end
end
test.assert_true(has_sword, "crafted item added")

ok, err = inv.craft(inventory, recipe)
test.assert_false(ok, "cannot craft without ingredients")

local success = test.summary()
os.exit(success and 0 or 1)
