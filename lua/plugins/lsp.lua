local lsp = require('lsp-zero')

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
