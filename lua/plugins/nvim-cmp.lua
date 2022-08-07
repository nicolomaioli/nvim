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
        end
    },
    formatting = {
        fields = {'kind', 'abbr', 'menu'},
        format = function(entry, vim_item)
            lspkind.cmp_format({mode = 'symbol_text', maxwidth = 50})(entry,
                vim_item)
            local strings = vim.split(lspkind.kind, '%s', {trimempty = true})
            lspkind.kind = ' ' .. strings[1] .. ' '
            lspkind.menu = '    (' .. strings[2] .. ')'

            return lspkind
        end
    },
    window = {completion = true, documentation = true},
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({select = true})
    }),
    sources = {{name = 'nvim_lsp'}, {name = 'buffer'}}
})

cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {{name = 'buffer'}}
})

cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({{name = 'path'}}, {{name = 'cmdline'}})
})
