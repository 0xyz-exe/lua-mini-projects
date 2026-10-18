-- Inventory and Crafting System
local M = {}

function M.new_inventory(capacity)
    return {
        items = {},
        capacity = capacity or 20,
        size = 0
    }
end

function M.add_item(inventory, item_id, quantity, stackable)
    quantity = quantity or 1
    stackable = stackable ~= false
    
    if stackable then
        for _, item in ipairs(inventory.items) do
            if item.id == item_id then
                item.quantity = item.quantity + quantity
                inventory.size = inventory.size + quantity
                return true
            end
        end
    end
    
    if #inventory.items >= inventory.capacity then
        return false, "inventory full"
    end
    
    table.insert(inventory.items, {
        id = item_id,
        quantity = quantity,
        stackable = stackable
    })
    inventory.size = inventory.size + quantity
    return true
end

function M.remove_item(inventory, item_id, quantity)
    quantity = quantity or 1
    
    for i, item in ipairs(inventory.items) do
        if item.id == item_id then
            if item.quantity >= quantity then
                item.quantity = item.quantity - quantity
                inventory.size = inventory.size - quantity
                if item.quantity == 0 then
                    table.remove(inventory.items, i)
                end
                return true
            else
                return false, "not enough items"
            end
        end
    end
    return false, "item not found"
end

function M.has_items(inventory, required)
    for item_id, quantity in pairs(required) do
        local found = false
        for _, item in ipairs(inventory.items) do
            if item.id == item_id and item.quantity >= quantity then
                found = true
                break
            end
        end
        if not found then return false end
    end
    return true
end

function M.craft(inventory, recipe)
    if not M.has_items(inventory, recipe.requires) then
        return false, "missing ingredients"
    end
    
    for item_id, quantity in pairs(recipe.requires) do
        M.remove_item(inventory, item_id, quantity)
    end
    
    M.add_item(inventory, recipe.produces, recipe.quantity or 1)
    return true
end

return M
