local lsp = require('lsp-zero')
local null_ls = require('null-ls')
local cmp = require('cmp')

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

lsp.preset('lsp-compe')

lsp.configure('sumneko_lua', {
    settings = {
        Lua = {
            diagnostics = { globals = { 'vim' } },
            workspace = {
                library = vim.api.nvim_get_runtime_file('', true),
                checkThirdParty = false,
            },
            telemetry = { enable = false },
        },
    },
})

-- Use the current LSP formatting capabilities (if available) to format on save
lsp.on_attach(function(client, bufnr)
    format_on_save(client, bufnr, function()
        vim.lsp.buf.format({ bufnr = bufnr })
    end)
end)

lsp.setup()

local cmp_config = lsp.defaults.cmp_config()

cmp.setup(cmp_config)

cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = { { name = 'buffer' } },
})

cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config
        .sources({ { name = 'path' } }, { { name = 'cmdline' } }),
})

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
                return utils.root_has_file({ 'package.json' })
            end,
        }),
        null_ls.builtins.diagnostics.eslint_d.with({
            condition = function(utils)
                return utils.root_has_file({ 'package.json' })
            end,
        }),
        null_ls.builtins.formatting.eslint_d.with({
            condition = function(utils)
                return utils.root_has_file({ 'package.json' })
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
                return utils.root_has_file({ 'package.json' })
            end,
        }),
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.lua_format,
    },
})
