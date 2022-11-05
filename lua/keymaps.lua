local set = vim.keymap.set

set('n', '<leader>sd', ':let @/=""<CR>')
set('n', '<leader>sr', ':%s/')
set('n', '<leader>xx', ':source %<CR>')
set('n', '<leader>cl', ':close<CR>')

set('n', '<leader>wh', '<C-w>h')
set('n', '<leader>wj', '<C-w>j')
set('n', '<leader>wk', '<C-w>k')
set('n', '<leader>wl', '<C-w>l')

set('t', '<Esc>', [[<C-\><C-n>]])
