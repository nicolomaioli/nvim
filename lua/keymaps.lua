local set = vim.keymap.set

set('n', '<leader>sd', ':let @/=""<CR>')
set('n', '<leader>sr', ':%s/')
set('n', '<leader>xx', ':source %<CR>')
set('n', '<leader>cl', ':close<CR>')

set('n', '<leader>wh', '<C-w>h')
set('n', '<leader>wj', '<C-w>j')
set('n', '<leader>wk', '<C-w>k')
set('n', '<leader>wl', '<C-w>l')

set('n', 'gd', vim.lsp.buf.definition)
set('n', 'gD', vim.lsp.buf.declaration)
set('n', 'gr', vim.lsp.buf.references)
set('n', 'gi', vim.lsp.buf.implementation)
set('n', 'ca', vim.lsp.buf.code_action)
set('n', 'K', vim.lsp.buf.hover)
set('n', '<leader>rn', vim.lsp.buf.rename)
set('n', '<C-k>', vim.lsp.buf.signature_help)
set('n', '<C-n>', vim.diagnostic.goto_prev)
set('n', '<C-p>', vim.diagnostic.goto_next)
