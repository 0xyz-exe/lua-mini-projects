#!/usr/bin/env lua
-- Tic-Tac-Toe Main

local game_module = require("game")

local function print_board(game)
    print("\n  1 2 3")
    for i = 1, 3 do
        io.write(i .. " ")
        for j = 1, 3 do
            io.write(game.board[i][j] .. " ")
        end
        print()
    end
    print()
end

local function play()
    local game = game_module.new_game()
    
    while not game.winner do
        print_board(game)
        print("Player " .. game.current_player .. "'s turn")
        io.write("Enter row (1-3): ")
        local row = tonumber(io.read())
        io.write("Enter col (1-3): ")
        local col = tonumber(io.read())
        
        local ok, err = game_module.make_move(game, row, col)
        if not ok then
            print("Invalid move: " .. (err or "unknown"))
        end
    end
    
    print_board(game)
    if game.winner == "draw" then
        print("Game ended in a draw!")
    else
        print("Player " .. game.winner .. " wins!")
    end
end

play()
