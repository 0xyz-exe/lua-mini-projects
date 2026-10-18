#!/usr/bin/env lua
package.path = package.path .. ";../../../shared/test_helpers/?.lua;../src/?.lua"

local test = require("simple_test")
local snake = require("snake")

print("Testing Snake Game Logic\n")

local game = snake.new_game(400, 400, 20)
test.assert_not_nil(game, "create game")
test.assert_equal(#game.snake, 1, "snake starts with 1 segment")
test.assert_equal(game.score, 0, "initial score 0")
test.assert_true(game.alive, "snake alive initially")

snake.change_direction(game, 0, 1)
test.assert_equal(game.direction.y, 1, "direction changed")

-- Simulate movement
snake.update(game)
test.assert_equal(game.snake[1].y, 6, "snake moved down")

-- Test wall collision
game = snake.new_game(400, 400, 20)
game.snake = {{x = 1, y = 1}}
game.direction = {x = -1, y = 0}
snake.update(game)
test.assert_false(game.alive, "wall collision kills snake")

-- Test self collision
game = snake.new_game(400, 400, 20)
game.snake = {{x = 5, y = 5}, {x = 4, y = 5}, {x = 3, y = 5}, {x = 3, y = 4}}
game.direction = {x = -1, y = 0}
snake.update(game)
test.assert_false(game.alive, "self collision kills snake")

local success = test.summary()
os.exit(success and 0 or 1)
