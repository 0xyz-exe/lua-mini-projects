-- Platformer Game Logic
local M = {}

function M.new_game()
    return {
        player = {
            x = 100, y = 300,
            w = 30, h = 40,
            vx = 0, vy = 0,
            on_ground = false
        },
        platforms = {
            {x = 0, y = 450, w = 800, h = 50},
            {x = 200, y = 350, w = 150, h = 20},
            {x = 400, y = 250, w = 150, h = 20},
            {x = 600, y = 350, w = 200, h = 20}
        },
        collectibles = {
            {x = 275, y = 320, collected = false},
            {x = 475, y = 220, collected = false},
            {x = 700, y = 320, collected = false}
        },
        score = 0,
        level = 1,
        alive = true,
        paused = false,
        gravity = 1200
    }
end

function M.update(game, dt)
    local p = game.player
    
    -- Input
    if love.keyboard.isDown("left", "a") then
        p.vx = -200
    elseif love.keyboard.isDown("right", "d") then
        p.vx = 200
    else
        p.vx = 0
    end
    
    -- Gravity
    p.vy = p.vy + game.gravity * dt
    
    -- Movement
    p.x = p.x + p.vx * dt
    p.y = p.y + p.vy * dt
    
    -- Platform collision
    p.on_ground = false
    for _, plat in ipairs(game.platforms) do
        if p.x + p.w > plat.x and p.x < plat.x + plat.w then
            if p.y + p.h > plat.y and p.y + p.h < plat.y + 20 and p.vy > 0 then
                p.y = plat.y - p.h
                p.vy = 0
                p.on_ground = true
            end
        end
    end
    
    -- Collectibles
    for _, coin in ipairs(game.collectibles) do
        if not coin.collected then
            local dist = math.sqrt((p.x + p.w/2 - coin.x)^2 + (p.y + p.h/2 - coin.y)^2)
            if dist < 25 then
                coin.collected = true
                game.score = game.score + 10
            end
        end
    end
    
    -- Death
    if p.y > 600 then
        game.alive = false
    end
end

return M
