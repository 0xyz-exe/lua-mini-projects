# Project 11: JSON Toolkit

JSON utilities with validation.

## Features

- Encode/decode JSON
- Schema validation
- File operations
- Error handling

## Usage

```lua
local json = require("json_toolkit")
local encoded = json.encode({name = "Alice"})
local decoded = json.decode(encoded)
json.save("data.json", data)
```

## Testing

```bash
cd projects/11-json-toolkit/tests
lua test_json.lua
```

## Limitations

Simple regex-based parser. For production use, install lua-cjson or dkjson.
