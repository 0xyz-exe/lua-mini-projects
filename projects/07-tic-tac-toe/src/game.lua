-- Tic-Tac-Toe Game Module
local M = {}

function M.new_game()
    return {
        board = {{".", ".", "."}, {".", ".", "."}, {".", ".", "."}},
        current_player = "X",
        winner = nil,
        moves = 0
    }
end

function M.make_move(game, row, col)
    if row < 1 or row > 3 or col < 1 or col > 3 then
        return false, "invalid position"
    end
    
    if game.board[row][col] ~= "." then
        return false, "position occupied"
    end
    
    if game.winner then
        return false, "game over"
    end
    
    game.board[row][col] = game.current_player
    game.moves = game.moves + 1
    
    if M.check_winner(game) then
        game.winner = game.current_player
    elseif game.moves == 9 then
        game.winner = "draw"
    else
        game.current_player = game.current_player == "X" and "O" or "X"
    end
    
    return true
end

function M.check_winner(game)
    local b = game.board
    local p = game.current_player
    
    -- Rows
    for i = 1, 3 do
        if b[i][1] == p and b[i][2] == p and b[i][3] == p then
            return true
        end
    end
    
    -- Columns
    for i = 1, 3 do
        if b[1][i] == p and b[2][i] == p and b[3][i] == p then
            return true
        end
    end
    
    -- Diagonals
    if b[1][1] == p and b[2][2] == p and b[3][3] == p then
        return true
    end
    if b[1][3] == p and b[2][2] == p and b[3][1] == p then
        return true
    end
    
    return false
end

function M.board_string(game)
    local lines = {}
    for i = 1, 3 do
        table.insert(lines, table.concat(game.board[i], " "))
    end
    return table.concat(lines, "\n")
end

return M
