local M = {
    on_attach = function(client)
        client.server_capabilities.documentFormattingProvider = true
        vim.cmd('autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync{}')
    end,
}

return M
