local lsp = require('lsp-zero')
local null_ls = require('null-ls')

-- IMPOTANT: ensure that null-ls is initialised *after* lsp-zero, otherwise it
-- overrides a number of functions and prevents Mason to initialise properly.

-- Declare an augroup to handle formatting on save
local lsp_formatting_augroup = vim.api.nvim_create_augroup('LspFormatting', {})

-- The format_on_save function takes an additional format_fn, which can be
-- overridden. In this config:
-- * if null-ls is attached, only use null-ls to format (avoid conflicts)
-- * otherwise use the current LSP formatting capabilities (if available)
local format_on_save = function(client, bufnr, format_fn)
    if client.supports_method 'textDocument/formatting' then
        vim.api.nvim_clear_autocmds {
            group = lsp_formatting_augroup,
            buffer = bufnr,
        }
        vim.api.nvim_create_autocmd('BufWritePre', {
            group = lsp_formatting_augroup,
            buffer = bufnr,
            callback = function()
                format_fn(bufnr)
            end,
        })
    end
end

lsp.preset('recommended')

lsp.configure('sumneko_lua', {
    settings = {
        Lua = {
            diagnostics = {globals = {'vim'}},
            workspace = {library = vim.api.nvim_get_runtime_file('', true)},
            telemetry = {enable = false},
        },
    },
})

-- Use the current LSP formatting capabilities (if available) to format on save
lsp.on_attach(function(client, bufnr)
    format_on_save(client, bufnr, function()
        vim.lsp.buf.format({bufnr = bufnr})
    end)
end)

lsp.setup()

-- If null-ls is attached, only use null-ls to format (avoid conflicts)
local null_ls_format = function(bufnr)
    vim.lsp.buf.format({
        filter = function(client)
            return client.name == 'null-ls'
        end,
        bufnr = bufnr,
    })
end

local null_opts = lsp.build_options('null-ls', {
    on_attach = function(client, bufnr)
        format_on_save(client, bufnr, null_ls_format)
    end,
})

null_ls.setup({
    on_attach = null_opts.on_attach,
    sources = {
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
    },
})
