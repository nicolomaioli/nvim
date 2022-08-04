local M = {
    on_attach = function(client)
        client.resolved_capabilities.document_formatting = true
        vim.cmd('autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync{}')
    end
}

return M
