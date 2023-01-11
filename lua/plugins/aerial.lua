return {
    'stevearc/aerial.nvim',
    event = 'BufEnter',
    keys = {
        { '<leader>ap', '<cmd>AerialPrev<CR>', desc = 'Aerial Prev' },
        { '<leader>an', '<cmd>AerialNext<CR>', desc = 'Aerial Next' },
        { '<leader>aa', '<cmd>AerialToggle<CR>', desc = 'Aerial Toggle' },
    },
    config = { backends = { 'treesitter', 'lsp', 'markdown', 'man' } },
}
