local null_ls = require('null-ls')

local sources = {
    null_ls.builtins.code_actions.eslint_d,
    null_ls.builtins.diagnostics.eslint_d,
    null_ls.builtins.formatting.eslint_d,
    null_ls.builtins.formatting.prettierd.with({
        filetypes = {
            'html',
            'json',
            'jsonc',
            'javascript',
            'javascriptreact',
            'typescript',
            'typescriptreact',
        },
    }),
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
}

local augroup = vim.api.nvim_create_augroup('LspFormatting', {})

local on_attach = function(client, bufnr)
    if client.supports_method 'textDocument/formatting' then
        vim.api.nvim_clear_autocmds {group = augroup, buffer = bufnr}
        vim.api.nvim_create_autocmd('BufWritePre', {
            group = augroup,
            buffer = bufnr,
            callback = function()
                vim.lsp.buf.format({bufnr = bufnr})
            end,
        })
    end
end

null_ls.setup {debug = true, sources = sources, on_attach = on_attach}
