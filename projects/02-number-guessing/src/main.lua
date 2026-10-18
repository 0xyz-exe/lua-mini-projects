#!/usr/bin/env lua
-- Number Guessing Game Main

local game_module = require("game")

local function load_high_scores()
    local scores = {}
    local file = io.open("../data/highscores.txt", "r")
    if file then
        for line in file:lines() do
            local difficulty, score = line:match("^(%w+):(%d+)$")
            if difficulty and score then
                scores[difficulty] = tonumber(score)
            end
        end
        file:close()
    end
    return scores
end

local function save_high_score(difficulty, score)
    local scores = load_high_scores()
    if not scores[difficulty] or score > scores[difficulty] then
        scores[difficulty] = score
        
        local file = io.open("../data/highscores.txt", "w")
        if file then
            for diff, sc in pairs(scores) do
                file:write(string.format("%s:%d\n", diff, sc))
            end
            file:close()
        end
        return true
    end
    return false
end

local function show_high_scores()
    local scores = load_high_scores()
    print("\n=== High Scores ===")
    for _, diff in ipairs({"easy", "medium", "hard"}) do
        print(string.format("%s: %d", diff:upper(), scores[diff] or 0))
    end
    print()
end

local function play_game()
    print("\n=== Number Guessing Game ===")
    print("\nSelect difficulty:")
    print("1. Easy (1-50, 10 attempts)")
    print("2. Medium (1-100, 7 attempts)")
    print("3. Hard (1-500, 10 attempts)")
    io.write("\nChoice (1-3): ")
    
    local choice = io.read()
    local difficulties = {"easy", "medium", "hard"}
    local difficulty = difficulties[tonumber(choice)]
    
    if not difficulty then
        print("Invalid choice. Using medium.")
        difficulty = "medium"
    end
    
    local game = game_module.new_game(difficulty)
    print(string.format("\nGuess a number between 1 and %d", game.max))
    print(string.format("You have %d attempts\n", game.attempts_left))
    
    while game.attempts_left > 0 and not game.won do
        io.write(string.format("Attempt %d/%d - Your guess: ", 
            #game.guesses + 1, 
            #game.guesses + game.attempts_left))
        
        local input = io.read()
        local guess = tonumber(input)
        
        if not guess then
            print("Please enter a valid number")
        else
            local hint, value = game_module.make_guess(game, guess)
            
            if hint == "correct" then
                local score = game_module.calculate_score(game)
                print(string.format("\n🎉 Correct! You won in %d guesses!", #game.guesses))
                print(string.format("Score: %d", score))
                
                if save_high_score(difficulty, score) then
                    print("★ NEW HIGH SCORE! ★")
                end
                break
            elseif hint == "higher" then
                print("Try higher")
            elseif hint == "lower" then
                print("Try lower")
            else
                print("Invalid guess")
            end
        end
    end
    
    if not game.won then
        print(string.format("\n💥 Game Over! The number was %d", game.target))
    end
end

-- Main loop
while true do
    print("\n1. Play Game")
    print("2. View High Scores")
    print("3. Quit")
    io.write("\nChoice: ")
    
    local choice = io.read()
    
    if choice == "1" then
        play_game()
    elseif choice == "2" then
        show_high_scores()
    elseif choice == "3" then
        print("Thanks for playing!")
        break
    else
        print("Invalid choice")
    end
end
