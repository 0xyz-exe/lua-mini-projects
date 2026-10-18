#!/usr/bin/env lua
package.path = package.path .. ";../../../shared/test_helpers/?.lua;../src/?.lua"

local test = require("simple_test")
local org = require("organizer")

print("Testing File Organizer\n")

test.assert_equal(org.get_extension("test.txt"), "txt", "txt extension")
test.assert_equal(org.get_extension("file.tar.gz"), "gz", "gz extension")
test.assert_equal(org.get_extension("noext"), "no_extension", "no extension")

local files = {
    {name = "doc1.pdf", path = "/tmp/doc1.pdf"},
    {name = "image.jpg", path = "/tmp/image.jpg"},
    {name = "script.lua", path = "/tmp/script.lua"}
}

local plan = org.organize_plan(files, "/tmp/organized")
test.assert_equal(#plan, 3, "plan has 3 items")
test.assert_equal(plan[1].ext, "pdf", "first file pdf")
test.assert_equal(plan[2].ext, "jpg", "second file jpg")

local results = org.execute_plan(plan, true)
test.assert_equal(results.success, 3, "dry run success")
test.assert_equal(results.failed, 0, "dry run no failures")

local success = test.summary()
os.exit(success and 0 or 1)
