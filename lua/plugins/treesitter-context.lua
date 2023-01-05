return {
    'nvim-treesitter/nvim-treesitter-context',
    event = 'BufRead',
    config = function()
        require('treesitter-context').setup()

        vim.api.nvim_set_hl(0, 'TreesitterContext', { bg = 'Black' })
        vim.api
            .nvim_set_hl(0, 'TreesitterContextBottom', { underdotted = true })
    end,
}
