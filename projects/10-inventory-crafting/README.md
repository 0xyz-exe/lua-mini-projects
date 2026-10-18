# Project 10: Inventory & Crafting System

Reusable game inventory with crafting recipes.

## Features

- Add/remove items
- Stackable items
- Capacity limits
- Crafting recipes
- Ingredient validation

## Usage

```lua
local inv = require("inventory")
local inventory = inv.new_inventory(20)
inv.add_item(inventory, "wood", 10)
inv.craft(inventory, recipe)
```

## Testing

```bash
cd projects/10-inventory-crafting/tests
lua test_inventory.lua
```
