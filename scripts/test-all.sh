#!/bin/bash
# Test runner for all Lua projects

LUA="${LUA_PATH:-lua}"
PROJECTS_DIR="$(dirname "$0")/../projects"

passed=0
failed=0

echo ""
echo "=== Running All Lua Tests ==="
echo ""

for project_dir in "$PROJECTS_DIR"/*; do
    if [ -d "$project_dir/tests" ]; then
        project=$(basename "$project_dir")
        
        for test_file in "$project_dir/tests"/test_*.lua; do
            if [ -f "$test_file" ]; then
                test_name=$(basename "$test_file")
                echo "Running $project/$test_name..."
                
                cd "$project_dir/tests"
                if $LUA "$test_name"; then
                    ((passed++))
                    echo "✓ PASSED"
                else
                    ((failed++))
                    echo "✗ FAILED"
                fi
                echo ""
                cd - > /dev/null
            fi
        done
    fi
done

echo "=== Test Summary ==="
echo "Passed: $passed"
echo "Failed: $failed"

[ $failed -eq 0 ]
