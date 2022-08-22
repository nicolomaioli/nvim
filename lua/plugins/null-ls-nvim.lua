local null_ls = require('null-ls')

null_ls.setup({
    on_attach = function(client, bufnr)
        if client.supports_method('textDocument/formatting') then
            vim.api.nvim_clear_autocmds({group = augroup, buffer = bufnr})
            vim.api.nvim_create_autocmd('BufWritePre', {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
                    vim.lsp.buf.formatting_sync()
                end,
            })
        end
    end,
    sources = {
        null_ls.builtins.code_actions.eslint_d,
        null_ls.builtins.formatting.prettierd,
        null_ls.builtins.formatting.black,
        null_ls.builtins.diagnostics.ansiblelint,
        null_ls.builtins.formatting.lua_format.with({
            extra_args = {
                '--column-limit',
                '80',
                '--column-table-limit',
                '80',
                '--indent-width',
                '4',
                '--tab-width',
                '4',
                '--no-use-tab',
                '--double-quote-to-single-quote',
                '--chop-down-table',
                '--chop-down-kv-table',
                '--no-align-table-field',
                '--chop-down-parameter',
                '--no-align-parameter',
                '--no-align-args',
                '--no-keep-simple-function-one-line',
                '--no-keep-simple-control-block-one-line',
                '--no-break-after-operator',
                '--break-after-table-lb',
                '--break-before-table-rb',
                '--extra-sep-at-table-end',
            },
        }),
    },
})
