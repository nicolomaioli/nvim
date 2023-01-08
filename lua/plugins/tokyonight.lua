return {
    'folke/tokyonight.nvim',
    lazy = false,
    enabled = true,
    config = function()
        require('tokyonight').setup({ style = 'storm' })
        vim.cmd.colorscheme('tokyonight')
    end,
}
