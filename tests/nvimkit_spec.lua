local file_exists = function(path)
    return vim.fn.filereadable(path) ~= 0
end

local check_dir_exists = function(path)
    return vim.fn.isdirectory(path) ~= 0
end

local test_dir = "nvimkit-test"

describe("nvimkit", function()
    it("can be required", function()
        require("nvimkit")
    end)
    it("can create a single route", function()
        require("nvimkit").setup({ open_file_after_creation = false })
        require("nvimkit").create_route("+page.svelte", test_dir)

        local test_file_route = vim.fn.getcwd() .. "/src/routes/" .. test_dir .. "/+page.svelte"
        local success = file_exists(test_file_route)

        assert(success)

        os.remove(test_file_route)
    end)
    it("can detect if typescript", function()
        require("nvimkit").setup()
        io.open(vim.fn.getcwd() .. "/tsconfig.json", "w"):close()
        local success = require("nvimkit")._detectTS()
        assert(success)
    end)
    it("can detect if not typescript", function()
        require("nvimkit").setup()
        os.remove(vim.fn.getcwd() .. "/tsconfig.json")
        local success = require("nvimkit")._detectTS()

        io.open(vim.fn.getcwd() .. "/tsconfig.json", "w"):close()
        assert.equals(false, success)
    end)
end)
