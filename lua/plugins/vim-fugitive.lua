local set = vim.keymap.set

set('n', '<leader>gc', ':Git checkout', { desc = 'Git checkout' })
set('n', '<leader>gn', ':Git checkout -b', { desc = 'Git new branch' })
set('n', '<leader>gf', ':Git fetch<CR>', { desc = 'Git fetch' })
set('n', '<leader>gl', ':Git pull<CR>', { desc = 'Git pull' })
set('n', '<leader>gs', ':Git<CR>', { desc = 'Git stage' })
set('n', '<leader>gp', ':Git push<CR>', { desc = 'Git push' })
