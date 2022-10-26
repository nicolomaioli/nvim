local cmp = require('cmp')
local lspkind = require('lspkind')

if (cmp == nil) then
    print('Could not load nvim-cmp')
    return
end

if (lspkind == nil) then
    print('Could not load lspkind-nvim')
    return
end

cmp.setup({
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    formatting = {
        fields = {'kind', 'abbr', 'menu'},
        format = lspkind.cmp_format(),
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({select = true}),
    }),
    sources = {{name = 'nvim_lsp'}, {{name = 'path'}}, {name = 'buffer'}},
})

cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {{name = 'buffer'}},
})

cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({{name = 'cmdline'}}, {{name = 'path'}}),
})
