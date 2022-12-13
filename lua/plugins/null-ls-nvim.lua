local null_ls = require('null-ls')

local sources = {
    null_ls.builtins.code_actions.eslint_d.with({
        condition = function(utils)
            return utils.root_has_file({'package.json'})
        end,
    }),
    null_ls.builtins.diagnostics.eslint_d.with({
        condition = function(utils)
            return utils.root_has_file({'package.json'})
        end,
    }),
    null_ls.builtins.formatting.eslint_d.with({
        condition = function(utils)
            return utils.root_has_file({'package.json'})
        end,
    }),
    null_ls.builtins.formatting.prettierd.with({
        filetypes = {
            'markdown',
            'html',
            'json',
            'jsonc',
            'javascript',
            'javascriptreact',
            'typescript',
            'typescriptreact',
        },
        condition = function(utils)
            return utils.root_has_file({'package.json'})
        end,
    }),
    null_ls.builtins.formatting.black,
    null_ls.builtins.diagnostics.ansiblelint,
    null_ls.builtins.formatting.lua_format.with({
        extra_args = {
            '--column-limit',
            '79',
            '--column-table-limit',
            '79',
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

-- lsp format on save
local lsp_formatting = function(bufnr)
    vim.lsp.buf.format({
        filter = function(client)
            return client.name == 'null-ls'
        end,
        bufnr = bufnr,
    })
end

local augroup = vim.api.nvim_create_augroup('LspFormatting', {})

local on_attach = function(client, bufnr)
    if client.supports_method 'textDocument/formatting' then
        vim.api.nvim_clear_autocmds {group = augroup, buffer = bufnr}
        vim.api.nvim_create_autocmd('BufWritePre', {
            group = augroup,
            buffer = bufnr,
            callback = function()
                lsp_formatting(bufnr)
            end,
        })
    end
end

null_ls.setup {debug = true, sources = sources, on_attach = on_attach}
