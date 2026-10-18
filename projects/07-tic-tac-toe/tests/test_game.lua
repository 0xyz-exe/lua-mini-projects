#!/usr/bin/env lua
package.path = package.path .. ";../../../shared/test_helpers/?.lua;../src/?.lua"

local test = require("simple_test")
local ttt = require("game")

print("Testing Tic-Tac-Toe\n")

local game = ttt.new_game()
test.assert_not_nil(game, "create game")
test.assert_equal(game.current_player, "X", "X starts")
test.assert_nil(game.winner, "no winner initially")

local ok = ttt.make_move(game, 1, 1)
test.assert_true(ok, "first move success")
test.assert_equal(game.board[1][1], "X", "X placed")
test.assert_equal(game.current_player, "O", "turn switched to O")

ok = ttt.make_move(game, 1, 1)
test.assert_false(ok, "cannot overwrite move")

-- Test horizontal win
game = ttt.new_game()
ttt.make_move(game, 1, 1) -- X
ttt.make_move(game, 2, 1) -- O
ttt.make_move(game, 1, 2) -- X
ttt.make_move(game, 2, 2) -- O
ttt.make_move(game, 1, 3) -- X wins
test.assert_equal(game.winner, "X", "X wins horizontally")

-- Test vertical win
game = ttt.new_game()
ttt.make_move(game, 1, 1) -- X
ttt.make_move(game, 1, 2) -- O
ttt.make_move(game, 2, 1) -- X
ttt.make_move(game, 2, 2) -- O
ttt.make_move(game, 3, 1) -- X wins
test.assert_equal(game.winner, "X", "X wins vertically")

-- Test diagonal win
game = ttt.new_game()
ttt.make_move(game, 1, 1) -- X
ttt.make_move(game, 1, 2) -- O
ttt.make_move(game, 2, 2) -- X
ttt.make_move(game, 1, 3) -- O
ttt.make_move(game, 3, 3) -- X wins
test.assert_equal(game.winner, "X", "X wins diagonally")

-- Test draw
game = ttt.new_game()
ttt.make_move(game, 1, 1) -- X
ttt.make_move(game, 1, 2) -- O
ttt.make_move(game, 1, 3) -- X
ttt.make_move(game, 2, 1) -- O
ttt.make_move(game, 2, 3) -- X
ttt.make_move(game, 2, 2) -- O
ttt.make_move(game, 3, 1) -- X
ttt.make_move(game, 3, 3) -- O
ttt.make_move(game, 3, 2) -- X
test.assert_equal(game.winner, "draw", "game ends in draw")

local success = test.summary()
os.exit(success and 0 or 1)
