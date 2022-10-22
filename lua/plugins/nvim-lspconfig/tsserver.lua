local M = {
    on_attach = function(client)
        if client.config.flags then
            client.config.flags.allow_incremental_sync = true
        end
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
    end,
    filetypes = {
        'typescript',
        'typescriptreact',
        'javascript',
        'javascriptreact',
    },
}

return M
