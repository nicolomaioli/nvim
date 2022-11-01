local cmp = require('cmp')
local lspkind = require('lspkind')
local luasnip = require('luasnip')
local mason = require('mason')
local mason_lspconfig = require('mason-lspconfig')
local lspconfig = require('lspconfig')
local cmp_nvim_lsp = require('cmp_nvim_lsp')
local lspconfig_defaults = lspconfig.util.default_config

-- [[
-- The order in this file matters!
-- cmp
-- mason
-- mason-lspconfig
-- lspconfig
-- ]]

if (cmp == nil) then
    print('Could not load nvim-cmp')
    return
end

local select_opts = {behavior = cmp.SelectBehavior.Select}

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    sources = {
        {name = 'path'},
        {name = 'nvim_lsp', keyword_length = 3},
        {name = 'buffer', keyword_length = 3},
        {name = 'luasnip', keyword_length = 2},
    },
    window = {documentation = cmp.config.window.bordered()},
    formatting = {
        fields = {'menu', 'abbr', 'kind'},
        format = lspkind.cmp_format(),
    },
    mapping = {
        ['<Up>'] = cmp.mapping.select_prev_item(select_opts),
        ['<Down>'] = cmp.mapping.select_next_item(select_opts),

        ['<C-p>'] = cmp.mapping.select_prev_item(select_opts),
        ['<C-n>'] = cmp.mapping.select_next_item(select_opts),

        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),

        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({select = false}),

        ['<C-d>'] = cmp.mapping(function(fallback)
            if luasnip.jumpable(1) then
                luasnip.jump(1)
            else
                fallback()
            end
        end, {'i', 's'}),

        ['<C-b>'] = cmp.mapping(function(fallback)
            if luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, {'i', 's'}),

        ['<Tab>'] = cmp.mapping(function(fallback)
            local col = vim.fn.col('.') - 1

            if cmp.visible() then
                cmp.select_next_item(select_opts)
            elseif col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
                fallback()
            else
                cmp.complete()
            end
        end, {'i', 's'}),

        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item(select_opts)
            else
                fallback()
            end
        end, {'i', 's'}),
    },
})

cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {{name = 'buffer'}},
})

cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({{name = 'cmdline'}, {name = 'path'}}),
})

mason.setup()
mason_lspconfig.setup()

lspconfig_defaults.capabilities = vim.tbl_deep_extend('force',
    lspconfig_defaults.capabilities, cmp_nvim_lsp.default_capabilities())

lspconfig.sumneko_lua.setup({
    settings = {
        Lua = {
            runtime = {version = 'LuaJIT'},
            diagnostics = {globals = {'vim', 'augroup'}},
            workspace = {
                library = vim.api.nvim_get_runtime_file('', true),
                checkThirdParty = false,
            },
            telemetry = {enable = false},
        },
    },
})

lspconfig.dockerls.setup({})
lspconfig.ansiblels.setup({})
lspconfig.gopls.setup({})
lspconfig.pyright.setup({})
lspconfig.terraformls.setup({})
lspconfig.tsserver.setup({})
lspconfig.yamlls.setup({})

vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'LSP actions',
    callback = function()
        local bufmap = function(mode, lhs, rhs)
            local opts = {buffer = true}
            vim.keymap.set(mode, lhs, rhs, opts)
        end

        bufmap('n', 'K', vim.lsp.buf.hover)
        bufmap('n', 'gd', vim.lsp.buf.definition)
        bufmap('n', 'gD', vim.lsp.buf.declaration)
        bufmap('n', 'gi', vim.lsp.buf.implementation)
        bufmap('n', 'go', vim.lsp.buf.type_definition)
        bufmap('n', 'gr', vim.lsp.buf.references)
        bufmap('n', '<C-k>', vim.lsp.buf.signature_help)
        bufmap('n', '<F2>', vim.lsp.buf.rename)
        bufmap('n', '<F4>', vim.lsp.buf.code_action)
        bufmap('x', '<F4>', vim.lsp.buf.range_code_action)
        bufmap('n', 'gl', vim.diagnostic.open_float)
        bufmap('n', '[d', vim.diagnostic.goto_prev)
        bufmap('n', ']d', vim.diagnostic.goto_next)
    end,
})

local load_diagnostics = function()
    -- Diagnostics
    vim.lsp.handlers['textDocument/publishDiagnostics'] =
        vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics,
            {virtual_text = false, signs = true})

    vim.fn.sign_define('LspDiagnosticsSignError',
        {text = '✘', texthl = 'LspDiagnosticsDefaultError'})
    vim.fn.sign_define('LspDiagnosticsSignWarning',
        {text = '▲', texthl = 'LspDiagnosticsDefaultWarning'})
    vim.fn.sign_define('LspDiagnosticsSignInformation', {
        text = '⚑',
        texthl = 'LspDiagnosticsDefaultInformation',
    })
    vim.fn.sign_define('LspDiagnosticsSignHint',
        {text = '', texthl = 'LspDiagnosticsDefaultHint'})
end

load_diagnostics()
