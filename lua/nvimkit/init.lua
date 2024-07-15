local M = {}

-- TODO - Add a way to switch between js/ts filetypes
-- TODO - add option to template the files?

M._default_config = {
    mode = "prod",
    svelte_route_dirname = "/src/routes/",
    route_filetypes = {
        "+page.svelte",
        "+page.ts",
        "+page.server.ts",
        "+server.ts",
        "+layout.svelte",
        "+layout.ts",
        "+layout.server.ts",
        "+error.svelte",
    }
}

M._config = nil;

-- checks if the setup function has been called, by seeing if the
-- _config variable is set
local check_setup = function()
    return M._config ~= nil
end

-- checks if a directory exists
local check_dir_exists = function(path)
    return vim.fn.isdirectory(path) ~= 0
end

-- checks if a file exists
local file_exists = function(path)
    return vim.fn.filereadable(path) ~= 0
end

-- merges two tables together, see: https://stackoverflow.com/a/1283399
local merge_tables = function(t1, t2)
    for k, v in pairs(t2) do t1[k] = v end
    return t1
end

local create_file = function(path, route_file)
    -- TODO Strip this out
    if M._config["mode"] == "debug" then
        print("Svelte Root: ", path)
        print("Filename: ", route_file)
        print("Full Path: ", path .. "/" .. route_file)
        print("Config: ", vim.inspect(M._config))
    end

    if check_dir_exists(path) == false then
        vim.fn.mkdir(path, "p")
    end

    if file_exists(path .. "/" .. route_file) == true then
        print("\nError: File already exists: ", path .. "/" .. route_file)
        return
    end

    local file = io.open(path .. "/" .. route_file, "w")
    if file == nil then
        print("Error: Could not create file: ", path)
        return
    end
    file:write("")
    file:close()
end


M.create_route = function(route, filename)
    if check_setup() == false then
        print("Error: Setup not called")
        return
    end

    local cwd = vim.fn.getcwd()
    local svelte_root = cwd .. M._config["svelte_route_dirname"] .. "/"

    if check_dir_exists(svelte_root) == false then
        error("Error: Svelte root directory not found: " .. cwd .. M._config["svelte_route_dirname"] .. "/", 0)
        return
    end

    local filename_index = vim.fn.inputlist({
        "Select the desired filetype: (or 0 to just create the route directory)",
        "1. +page.svelte",
        "2. +page.ts",
        "3. +page.server.ts",
        "4. +server.ts",
        "5. +layout.svelte",
        "6. +layout.ts",
        "7. +layout.server.ts",
        "8. +error.svelte",
    })

    if filename == nil then
        filename = M._config["route_filetypes"][filename_index]
    end

    if route == nil then
        route = vim.fn.input("Enter the route: ")
    end

    create_file(svelte_root .. route, filename)
end

M.setup = function(opts)
    if opts == nil then
        opts = M._default_config
    end

    M._config = merge_tables(M._default_config, opts)

    -- TODO let users pass the route filetype and route name in the function
    vim.api.nvim_create_user_command("NvimkitCreateRoute", "lua require('nvimkit').create_route()",
        { desc = "Create a new sveltkit route" })
end

return M
