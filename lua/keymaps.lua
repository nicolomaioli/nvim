local set = vim.keymap.set

set('n', '<leader>sd', ':let @/=""<CR>')
set('n', '<leader>sr', ':%s/')
set('n', '<leader>xx', ':source %<CR>')
set('n', '<leader>cl', ':close<CR>')

set('n', '<leader>wh', '<C-w>h')
set('n', '<leader>wj', '<C-w>j')
set('n', '<leader>wk', '<C-w>k')
set('n', '<leader>wl', '<C-w>l')

set('n', '<silent> gd', vim.lsp.buf.definition)
set('n', '<silent> gD', vim.lsp.buf.declaration)
set('n', '<silent> gr', vim.lsp.buf.references)
set('n', '<silent> gi', vim.lsp.buf.implementation)
set('n', '<silent> ca', vim.lsp.buf.code_action)
set('n', '<silent> K', vim.lsp.buf.hover)
set('n', '<silent> <leader>rn', vim.lsp.buf.rename)
set('n', '<silent> <C-k>', vim.lsp.buf.signature_help)
set('n', '<silent> <C-n>', vim.diagnostic.goto_prev)
set('n', '<silent> <C-p>', vim.diagnostic.goto_next)
