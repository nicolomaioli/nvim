return {
    'ellisonleao/gruvbox.nvim',
    event = 'VeryLazy',
    enabled = false,
    config = function()
        require('gruvbox').setup({
            contrast = 'soft',
            overrides = {
                Normal = { bg = 'none' },
                NormalFloat = { bg = 'none' },
            },
        })
        vim.cmd.colorscheme('gruvbox')
    end,
}
