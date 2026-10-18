-- Number Guessing Game Logic
local M = {}

M.difficulties = {
    easy = {max = 50, attempts = 10},
    medium = {max = 100, attempts = 7},
    hard = {max = 500, attempts = 10}
}

function M.new_game(difficulty)
    local config = M.difficulties[difficulty or "medium"]
    if not config then
        return nil, "invalid difficulty"
    end
    
    math.randomseed(os.time())
    -- Generate multiple randoms to improve distribution
    for i = 1, 5 do math.random() end
    
    return {
        target = math.random(1, config.max),
        max = config.max,
        attempts_left = config.attempts,
        guesses = {},
        won = false,
        difficulty = difficulty
    }
end

function M.make_guess(game, guess)
    if game.won or game.attempts_left == 0 then
        return nil, "game over"
    end
    
    if type(guess) ~= "number" or guess < 1 or guess > game.max then
        return nil, "invalid guess"
    end
    
    table.insert(game.guesses, guess)
    game.attempts_left = game.attempts_left - 1
    
    if guess == game.target then
        game.won = true
        return "correct", game.target
    elseif guess < game.target then
        return "higher", nil
    else
        return "lower", nil
    end
end

function M.calculate_score(game)
    if not game.won then return 0 end
    local guesses_used = #game.guesses
    local config = M.difficulties[game.difficulty]
    return math.floor(1000 * (config.attempts - guesses_used + 1) / config.attempts)
end

return M
