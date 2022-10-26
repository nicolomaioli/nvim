local M = {
    settings = {
        Lua = {
            runtime = {version = 'LuaJIT'},
            diagnostics = {globals = {'vim', 'augroup'}},
            workspace = {
                library = vim.api.nvim_get_runtime_file('', true),
                checkThirdParty = false,
            },
            telemetry = {enable = false},
        },
    },
}

return M
