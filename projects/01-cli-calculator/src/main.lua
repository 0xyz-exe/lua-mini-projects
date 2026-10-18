#!/usr/bin/env lua
-- CLI Calculator Main

local calc = require("calculator")

local function print_usage()
    print([[
CLI Calculator

Usage:
  lua main.lua <num1> <operation> <num2>
  lua main.lua --interactive

Operations: + - * / % ^

Examples:
  lua main.lua 10 + 5
  lua main.lua 20 / 4
  lua main.lua 2 ^ 8
]])
end

local function interactive_mode()
    print("Calculator - Interactive Mode")
    print("Type 'quit' or 'exit' to quit\n")
    
    while true do
        io.write("Enter calculation (e.g., 10 + 5): ")
        local input = io.read()
        
        if not input or input:lower() == "quit" or input:lower() == "exit" then
            print("Goodbye!")
            break
        end
        
        local num1, op, num2 = input:match("^([%d%.%-]+)%s*([+%-%*/%%^])%s*([%d%.%-]+)$")
        
        if not num1 or not op or not num2 then
            print("Invalid input. Use format: number operator number")
        else
            num1, num2 = tonumber(num1), tonumber(num2)
            if not num1 or not num2 then
                print("Invalid numbers")
            else
                local result, err = calc.calculate(op, num1, num2)
                if result then
                    print(string.format("Result: %.2f", result))
                else
                    print("Error: " .. err)
                end
            end
        end
    end
end

-- Main execution
local args = {...}

if #args == 0 or args[1] == "--help" or args[1] == "-h" then
    print_usage()
elseif args[1] == "--interactive" or args[1] == "-i" then
    interactive_mode()
elseif #args == 3 then
    local num1, op, num2 = tonumber(args[1]), args[2], tonumber(args[3])
    
    if not num1 or not num2 then
        print("Error: Invalid numbers")
        os.exit(1)
    end
    
    local result, err = calc.calculate(op, num1, num2)
    if result then
        print(result)
    else
        print("Error: " .. err)
        os.exit(1)
    end
else
    print("Error: Invalid arguments")
    print_usage()
    os.exit(1)
end
