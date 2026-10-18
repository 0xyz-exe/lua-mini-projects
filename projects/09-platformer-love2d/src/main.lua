-- main.lua for LÖVE 2D Platformer
-- Run with: love projects/09-platformer-love2d/src

local platform = require("platform")

local game
local camera_x = 0

function love.load()
    game = platform.new_game()
end

function love.update(dt)
    if game.paused or not game.alive then return end
    
    platform.update(game, dt)
    
    -- Camera follows player
    camera_x = math.max(0, game.player.x - 200)
end

function love.draw()
    love.graphics.push()
    love.graphics.translate(-camera_x, 0)
    
    -- Draw platforms
    love.graphics.setColor(0.5, 0.5, 0.5)
    for _, plat in ipairs(game.platforms) do
        love.graphics.rectangle("fill", plat.x, plat.y, plat.w, plat.h)
    end
    
    -- Draw collectibles
    love.graphics.setColor(1, 1, 0)
    for _, coin in ipairs(game.collectibles) do
        if not coin.collected then
            love.graphics.circle("fill", coin.x, coin.y, 8)
        end
    end
    
    -- Draw player
    love.graphics.setColor(0, 0.5, 1)
    love.graphics.rectangle("fill", game.player.x, game.player.y, 
        game.player.w, game.player.h)
    
    love.graphics.pop()
    
    -- UI
    love.graphics.setColor(1, 1, 1)
    love.graphics.print("Score: " .. game.score, 10, 10)
    love.graphics.print("Level: " .. game.level, 10, 30)
    
    if game.paused then
        love.graphics.print("PAUSED", 300, 250)
    end
    
    if not game.alive then
        love.graphics.print("GAME OVER - Press R", 250, 250)
    end
end

function love.keypressed(key)
    if key == "space" and game.player.on_ground then
        game.player.vy = -400
        game.player.on_ground = false
    elseif key == "p" then
        game.paused = not game.paused
    elseif key == "r" then
        game = platform.new_game()
        camera_x = 0
    elseif key == "escape" then
        love.event.quit()
    end
end

function love.keyreleased(key)
end
