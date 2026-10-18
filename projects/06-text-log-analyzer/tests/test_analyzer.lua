#!/usr/bin/env lua
package.path = package.path .. ";../../../shared/test_helpers/?.lua;../src/?.lua"

local test = require("simple_test")
local analyzer = require("analyzer")

print("Testing Text Analyzer\n")

local text = "Hello world\nThis is a test\nHello again"
local stats = analyzer.analyze_text(text)
test.assert_equal(stats.lines, 3, "line count")
test.assert_equal(stats.words, 8, "word count")
test.assert_true(stats.chars > 0, "char count")

local freq = analyzer.word_frequency("the cat and the dog", 2)
test.assert_equal(#freq, 2, "top 2 words")
test.assert_equal(freq[1].word, "the", "most frequent word")
test.assert_equal(freq[1].count, 2, "the appears twice")

local results = analyzer.search_lines(text, "Hello")
test.assert_equal(#results, 2, "two Hello matches")
test.assert_equal(results[1].line_num, 1, "first match line 1")

local success = test.summary()
os.exit(success and 0 or 1)
