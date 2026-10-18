# Project 01: CLI Calculator

Command-line calculator with basic arithmetic operations.

## Features

- Addition, subtraction, multiplication, division
- Modulo and exponentiation
- Interactive mode and command-line arguments
- Input validation
- Division-by-zero handling

## Usage

**Command-line mode:**
```bash
lua src/main.lua 10 + 5
lua src/main.lua 20 / 4
lua src/main.lua 2 ^ 8
```

**Interactive mode:**
```bash
lua src/main.lua --interactive
```

## Testing

```bash
cd tests
lua test_calculator.lua
```

## Dependencies

- Lua 5.3+
- No external dependencies
