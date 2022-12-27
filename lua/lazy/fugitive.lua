return {
    'tpope/vim-fugitive',
    keys = {
        { '<leader>gc', ':Git checkout', desc = 'Git checkout' },
        { '<leader>gn', ':Git checkout -b ', desc = 'Git new branch' },
        { '<leader>gf', ':Git fetch<CR>', desc = 'Git fetch' },
        { '<leader>gl', ':Git pull<CR>', desc = 'Git pull' },
        { '<leader>gs', ':Git<CR>', desc = 'Git stage' },
        { '<leader>gp', ':Git push<CR>', desc = 'Git push' },
    },
}
