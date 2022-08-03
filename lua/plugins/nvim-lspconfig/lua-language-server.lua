local root = vim.fn.stdpath('config') .. '/vendors/lua-language-server'
local binary = root .. '/bin/lua-language-server'

local M = {
    on_attach = function(client)
        client.resolved_capabilities.document_formatting = false
        client.resolved_capabilities.document_range_formatting = false
    end,
    cmd = {binary, '-E', root .. '/main.lua'},
    settings = {
        Lua = {
            runtime = {version = 'LuaJIT'},
            diagnostics = {globals = {'vim'}},
            workspace = {
                library = vim.api.nvim_get_runtime_file('', true),
                checkThirdParty = false
            },
            telemetry = {enable = false}
        }
    }
}

return M
