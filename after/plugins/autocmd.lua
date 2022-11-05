vim.api.nvim_create_autocmd('BufWritePre',
    {callback = vim.lsp.buf.format({async = false})})
