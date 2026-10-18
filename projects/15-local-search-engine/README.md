# Project 15: Local Search Engine

Text indexing and keyword search.

## Features

- Document indexing
- Tokenization
- Keyword search
- Relevance ranking
- Result limiting

## Usage

```lua
local search = require("search")
local index = search.new_index()

search.add_document(index, "doc1", "The quick brown fox")
local results = search.search(index, "quick fox")
```

## Testing

```bash
cd projects/15-local-search-engine/tests
lua test_search.lua
```

## Limitations

Basic TF scoring only. No stemming, stop words, or advanced NLP.
