local cmp = require('cmp')
local lspkind = require('lspkind')
local luasnip = require('luasnip')
local mason = require('mason')
local mason_lspconfig = require('mason-lspconfig')
local neodev = require('neodev')
local lspconfig = require('lspconfig')
local cmp_nvim_lsp = require('cmp_nvim_lsp')
local wtfm = require('wtfm')

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

local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0
               and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(
            col, col):match('%s') == nil
end

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
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
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
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            elseif has_words_before() then
                cmp.complete()
            else
                fallback()
            end
        end, {'i', 's'}),

        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, {'i', 's'}),
    },
})

cmp.setup.cmdline({'/', '?'}, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {{name = 'buffer'}},
})

cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({{name = 'path'}}, {{name = 'cmdline'}}),
})

mason.setup()
mason_lspconfig.setup()

lspconfig.util.default_config.capabilities =
    vim.tbl_deep_extend('force', lspconfig.util.default_config.capabilities,
        cmp_nvim_lsp.default_capabilities())

neodev.setup({setup_jsonls = false})

lspconfig.sumneko_lua.setup({
    settings = {
        Lua = {
            completion = {callSnippet = 'Replace'},
            diagnostics = {globals = {'vim'}},
        },
    },
})

lspconfig.dockerls.setup({})
lspconfig.ansiblels.setup({})
lspconfig.gopls.setup({})
lspconfig.pyright.setup({})
lspconfig.terraformls.setup({})
lspconfig.yamlls.setup({})
lspconfig.emmet_ls.setup({})
lspconfig.prismals.setup({})

lspconfig.tsserver.setup({
    root_dir = lspconfig.util.root_pattern('package.json'),
})

lspconfig.denols.setup({
    root_dir = lspconfig.util.root_pattern('deno.json', 'deno.jsonc'),
})

lspconfig.tailwindcss.setup({
    root_dir = lspconfig.util.root_pattern('tailwind.config.js',
        'tailwind.config.cjs', 'tailwind.config.ts', 'postcss.config.js',
        'postcss.config.cjs', 'postcss.config.ts', 'package.json'),
})

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
        bufmap('n', '<leader>dy', wtfm.yank_diagnostic)
    end,
})

local load_diagnostics = function()
    -- Diagnostics
    vim.lsp.handlers['textDocument/publishDiagnostics'] =
        vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics,
            {virtual_text = false, signs = true})
    vim.lsp.handlers['textDocument/hover'] =
        vim.lsp.with(vim.lsp.handlers.hover, {border = 'rounded'})
    vim.lsp.handlers['textDocument/signatureHelp'] =
        vim.lsp.with(vim.lsp.handlers.signature_help, {border = 'rounded'})

    local signs = {Error = '', Warn = '', Hint = '', Info = ''}
    for type, icon in pairs(signs) do
        local hl = 'DiagnosticSign' .. type
        vim.fn.sign_define(hl, {text = icon, texthl = hl, numhl = hl})
    end

    vim.diagnostic.config({
        virtual_text = false,
        signs = {active = signs},
        update_in_insert = true,
        underline = true,
        severity_sort = true,
        float = {
            focusable = false,
            style = 'minimal',
            border = 'rounded',
            source = 'always',
            header = '',
            prefix = '',
        },
    })
end

load_diagnostics()
