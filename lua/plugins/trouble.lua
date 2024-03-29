return {
    'folke/trouble.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    event = 'LspAttach',
    keys = {
        {
            '<leader>xx',
            '<cmd>TroubleToggle<cr>',
            silent = true,
            noremap = true,
            desc = 'Trouble',
        },
        {
            '<leader>xw',
            '<cmd>TroubleToggle workspace_diagnostics<cr>',
            silent = true,
            noremap = true,
            desc = 'Trouble workspace diagnostics',
        },
        {
            '<leader>xd',
            '<cmd>TroubleToggle document_diagnostics<cr>',
            silent = true,
            noremap = true,
            desc = 'Trouble document diagnostics',
        },
        {
            '<leader>xl',
            '<cmd>TroubleToggle loclist<cr>',
            silent = true,
            noremap = true,
            desc = 'Trouble loclist',
        },
    },
    config = true,
}
