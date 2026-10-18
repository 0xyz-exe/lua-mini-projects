# Project 12: HTTP Client

HTTP client interface with mock implementation.

## Features

- GET/POST requests
- JSON response parsing
- Mock server for testing
- Error handling

## Usage

```lua
local http = require("http_client")
local response = http.get("https://api.example.com")
local data = http.parse_json_response(response)
```

## Testing

```bash
cd projects/12-http-client/tests
lua test_http.lua
```

## Limitations

Mock implementation only. For real HTTP, install luasocket:
```bash
luarocks install luasocket
```
