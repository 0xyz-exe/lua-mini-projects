#!/usr/bin/env lua
package.path = package.path .. ";../../../shared/test_helpers/?.lua;../src/?.lua"

local test = require("simple_test")
local game_module = require("game")

print("Testing Number Guessing Game\n")

-- Test game creation
local game = game_module.new_game("easy")
test.assert_not_nil(game, "create easy game")
test.assert_equal(game.max, 50, "easy max is 50")
test.assert_equal(game.attempts_left, 10, "easy has 10 attempts")
test.assert_true(game.target >= 1 and game.target <= 50, "target in range")

game = game_module.new_game("medium")
test.assert_equal(game.max, 100, "medium max is 100")

game = game_module.new_game("hard")
test.assert_equal(game.max, 500, "hard max is 500")

local result, err = game_module.new_game("invalid")
test.assert_nil(result, "invalid difficulty returns nil")
test.assert_equal(err, "invalid difficulty", "error message")

-- Test guessing logic
game = game_module.new_game("easy")
game.target = 25 -- Override for testing

local hint, value = game_module.make_guess(game, 25)
test.assert_equal(hint, "correct", "correct guess returns 'correct'")
test.assert_equal(value, 25, "returns target on win")
test.assert_true(game.won, "game marked as won")

game = game_module.new_game("easy")
game.target = 30

hint = game_module.make_guess(game, 20)
test.assert_equal(hint, "higher", "lower guess returns 'higher'")

hint = game_module.make_guess(game, 40)
test.assert_equal(hint, "lower", "higher guess returns 'lower'")

-- Test invalid guesses
hint, err = game_module.make_guess(game, 0)
test.assert_nil(hint, "guess out of range returns nil")
test.assert_equal(err, "invalid guess", "invalid guess error")

hint, err = game_module.make_guess(game, 100)
test.assert_nil(hint, "guess above max returns nil")

-- Test game over
game = game_module.new_game("easy")
game.attempts_left = 0
hint, err = game_module.make_guess(game, 25)
test.assert_nil(hint, "no guesses when attempts exhausted")
test.assert_equal(err, "game over", "game over error")

-- Test scoring
game = game_module.new_game("easy")
game.target = 25
game_module.make_guess(game, 25)
local score = game_module.calculate_score(game)
test.assert_true(score > 0, "winning gives positive score")

game = game_module.new_game("easy")
game.won = false
score = game_module.calculate_score(game)
test.assert_equal(score, 0, "losing gives zero score")

local success = test.summary()
os.exit(success and 0 or 1)
