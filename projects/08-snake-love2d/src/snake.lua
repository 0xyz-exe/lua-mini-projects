-- Snake Game Logic (LÖVE-independent)
local M = {}

function M.new_game(width, height, cell_size)
    math.randomseed(os.time())
    for i = 1, 5 do math.random() end
    
    local grid_w = math.floor(width / cell_size)
    local grid_h = math.floor(height / cell_size)
    
    return {
        snake = {{x = 5, y = 5}},
        direction = {x = 1, y = 0},
        food = {x = math.random(1, grid_w), y = math.random(1, grid_h)},
        grid_w = grid_w,
        grid_h = grid_h,
        cell_size = cell_size,
        score = 0,
        alive = true,
        paused = false
    }
end

function M.change_direction(game, dx, dy)
    -- Prevent reversing
    if dx ~= -game.direction.x or dy ~= -game.direction.y then
        game.direction = {x = dx, y = dy}
    end
end

function M.update(game)
    if not game.alive or game.paused then return end
    
    local head = game.snake[1]
    local new_head = {
        x = head.x + game.direction.x,
        y = head.y + game.direction.y
    }
    
    -- Wall collision
    if new_head.x < 1 or new_head.x > game.grid_w or
       new_head.y < 1 or new_head.y > game.grid_h then
        game.alive = false
        return
    end
    
    -- Self collision
    for _, segment in ipairs(game.snake) do
        if new_head.x == segment.x and new_head.y == segment.y then
            game.alive = false
            return
        end
    end
    
    table.insert(game.snake, 1, new_head)
    
    -- Food collision
    if new_head.x == game.food.x and new_head.y == game.food.y then
        game.score = game.score + 10
        game.food = {
            x = math.random(1, game.grid_w),
            y = math.random(1, game.grid_h)
        }
    else
        table.remove(game.snake)
    end
end

return M
