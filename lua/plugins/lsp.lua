local lsp = require('lsp-zero')
local cmp = require('cmp')

lsp.preset('recommended')

lsp.ensure_installed({
    'dockerls',
    'ansiblels',
    'gopls',
    'pyright',
    'terraformls',
    'yamlls',
    'tsserver',
    'eslint',
    'sumneko_lua',
})

lsp.nvim_workspace()
lsp.setup()

cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {{name = 'buffer'}},
})

cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({{name = 'cmdline'}}, {{name = 'path'}}),
})
