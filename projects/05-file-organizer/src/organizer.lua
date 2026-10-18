-- File Organizer Module
local M = {}

function M.get_extension(filename)
    return filename:match("%.([^%.]+)$") or "no_extension"
end

function M.scan_directory(path)
    local files = {}
    local handle = io.popen('ls -1 "' .. path .. '" 2>/dev/null')
    if not handle then return files end
    
    for filename in handle:lines() do
        local filepath = path .. "/" .. filename
        local attr = io.open(filepath, "r")
        if attr then
            attr:close()
            table.insert(files, {name = filename, path = filepath})
        end
    end
    handle:close()
    return files
end

function M.organize_plan(files, dest_base)
    local plan = {}
    for _, file in ipairs(files) do
        local ext = M.get_extension(file.name)
        local dest_dir = dest_base .. "/" .. ext
        local dest_path = dest_dir .. "/" .. file.name
        table.insert(plan, {
            source = file.path,
            dest = dest_path,
            dest_dir = dest_dir,
            ext = ext
        })
    end
    return plan
end

function M.execute_plan(plan, dry_run)
    local results = {success = 0, failed = 0, errors = {}}
    
    for _, item in ipairs(plan) do
        if dry_run then
            results.success = results.success + 1
        else
            -- Create directory
            os.execute('mkdir -p "' .. item.dest_dir .. '"')
            
            -- Move file
            local ok = os.rename(item.source, item.dest)
            if ok then
                results.success = results.success + 1
            else
                results.failed = results.failed + 1
                table.insert(results.errors, item.source)
            end
        end
    end
    
    return results
end

return M
