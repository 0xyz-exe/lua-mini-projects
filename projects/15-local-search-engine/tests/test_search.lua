#!/usr/bin/env lua
package.path = package.path .. ";../../../shared/test_helpers/?.lua;../src/?.lua"

local test = require("simple_test")
local search = require("search")

print("Testing Search Engine\n")

local index = search.new_index()
test.assert_not_nil(index, "create index")

local tokens = search.tokenize("Hello World")
test.assert_equal(#tokens, 2, "tokenize two words")
test.assert_equal(tokens[1], "hello", "lowercase token")

local ok = search.add_document(index, "doc1", "The quick brown fox")
test.assert_true(ok, "add document")
test.assert_equal(index.doc_count, 1, "doc count increased")

search.add_document(index, "doc2", "The lazy dog")
search.add_document(index, "doc3", "Quick brown animals")

local results = search.search(index, "quick brown")
test.assert_equal(#results, 2, "two results for 'quick brown'")
test.assert_equal(results[1].doc_id, "doc1", "best match first")

results = search.search(index, "the", 1)
test.assert_equal(#results, 1, "limit results")

results = search.search(index, "nonexistent")
test.assert_equal(#results, 0, "no results for unknown term")

local success = test.summary()
os.exit(success and 0 or 1)
