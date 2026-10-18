-- main.lua for LÖVE Snake Game
-- Run with: love projects/08-snake-love2d/src

local snake = require("snake")

local game
local update_timer = 0
local update_interval = 0.15

function love.load()
    game = snake.new_game(600, 600, 20)
end

function love.update(dt)
    update_timer = update_timer + dt
    
    if update_timer >= update_interval then
        update_timer = 0
        snake.update(game)
    end
end

function love.draw()
    -- Draw snake
    love.graphics.setColor(0, 1, 0)
    for _, segment in ipairs(game.snake) do
        love.graphics.rectangle("fill",
            (segment.x - 1) * game.cell_size,
            (segment.y - 1) * game.cell_size,
            game.cell_size - 2, game.cell_size - 2)
    end
    
    -- Draw food
    love.graphics.setColor(1, 0, 0)
    love.graphics.rectangle("fill",
        (game.food.x - 1) * game.cell_size,
        (game.food.y - 1) * game.cell_size,
        game.cell_size - 2, game.cell_size - 2)
    
    -- Draw score
    love.graphics.setColor(1, 1, 1)
    love.graphics.print("Score: " .. game.score, 10, 10)
    
    if game.paused then
        love.graphics.print("PAUSED - Press P", 250, 300)
    end
    
    if not game.alive then
        love.graphics.print("GAME OVER - Press R", 230, 300)
    end
end

function love.keypressed(key)
    if key == "up" or key == "w" then
        snake.change_direction(game, 0, -1)
    elseif key == "down" or key == "s" then
        snake.change_direction(game, 0, 1)
    elseif key == "left" or key == "a" then
        snake.change_direction(game, -1, 0)
    elseif key == "right" or key == "d" then
        snake.change_direction(game, 1, 0)
    elseif key == "p" then
        game.paused = not game.paused
    elseif key == "r" then
        game = snake.new_game(600, 600, 20)
    elseif key == "escape" then
        love.event.quit()
    end
end
