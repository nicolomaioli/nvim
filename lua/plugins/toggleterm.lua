return {
    'akinsho/toggleterm.nvim',
    version = '2.*',
    keys = {
        {
            '<c-t>',
            '<Cmd>exe v:count1 . "ToggleTerm"<CR>',
            silent = true,
            desc = 'Toggle terminal',
        },
        {
            '<leader>tt',
            '<Cmd>exe v:count1 . "ToggleTerm"<CR>',
            silent = true,
            desc = 'Toggle terminal',
        },
    },
    config = {
        size = function(term)
            if term.direction == 'horizontal' then
                return vim.o.lines * 0.3
            elseif term.direction == 'vertical' then
                return vim.o.columns * 0.4
            end
        end,
        direction = 'vertical',
        open_mapping = [[<C-`>]],
    },
}
