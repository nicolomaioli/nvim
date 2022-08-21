local M = {
    on_attach = function(client)
        if client.config.flags then
            client.config.flags.allow_incremental_sync = true
        end
        client.resolved_capabilities.document_formatting = false
        client.resolved_capabilities.document_range_formatting = false
    end,
    filetypes = {
        'typescript',
        'typescriptreact',
        'javascript',
        'javascriptreact',
    },
}

return M
