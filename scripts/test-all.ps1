#!/usr/bin/env pwsh
# Test runner for all Lua projects

$LUA = "C:\Users\wondr\AppData\Local\Programs\Lua\bin\lua.exe"
$ProjectsDir = "$PSScriptRoot\..\projects"

$passed = 0
$failed = 0

Write-Host "`n=== Running All Lua Tests ===`n" -ForegroundColor Cyan

Get-ChildItem -Path $ProjectsDir -Directory | ForEach-Object {
    $project = $_.Name
    $testDir = Join-Path $_.FullName "tests"
    
    if (Test-Path $testDir) {
        Get-ChildItem -Path $testDir -Filter "test_*.lua" | ForEach-Object {
            $testFile = $_.FullName
            Write-Host "Running $project/$($_.Name)..." -ForegroundColor Yellow
            
            Push-Location $testDir
            & $LUA $_.Name
            
            if ($LASTEXITCODE -eq 0) {
                $passed++
                Write-Host "✓ PASSED`n" -ForegroundColor Green
            } else {
                $failed++
                Write-Host "✗ FAILED`n" -ForegroundColor Red
            }
            Pop-Location
        }
    }
}

Write-Host "`n=== Test Summary ===" -ForegroundColor Cyan
Write-Host "Passed: $passed" -ForegroundColor Green
Write-Host "Failed: $failed" -ForegroundColor Red

if ($failed -gt 0) {
    exit 1
}
