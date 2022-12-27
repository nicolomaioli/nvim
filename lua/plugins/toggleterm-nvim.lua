local set = vim.keymap.set

require('toggleterm').setup({
    size = function(term)
        if term.direction == 'horizontal' then
            return vim.o.lines * 0.3
        elseif term.direction == 'vertical' then
            return vim.o.columns * 0.4
        end
    end,
    direction = 'vertical',
    open_mapping = [[<C-`>]],
})

set('n', '<c-t>', '<Cmd>exe v:count1 . "ToggleTerm"<CR>',
    { silent = true, desc = 'Toggle terminal' })
