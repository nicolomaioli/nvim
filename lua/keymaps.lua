local set = vim.keymap.set

set('n', '<leader>sr', ':%s/', { desc = 'Search and replace' })
set('n', '<leader>cl', ':close<CR>', { desc = 'Close buffer' })

local tabedit_with_curpos = function()
    -- Wraps tabedit to retain cursor position
    local curpos = vim.fn.getpos('.')
    vim.cmd [[tabedit %]]
    vim.fn.setpos('.', curpos)
end

set('n', '<leader>te', tabedit_with_curpos, { desc = 'Tab edit' })
set('n', '<leader>tc', ':tabclose<CR>', { desc = 'Close tab' })
set('n', '<leader>tn', ':tabnext<CR>', { desc = 'Move to next tab' })
set('n', '<leader>tp', ':tabprevious<CR>', { desc = 'Move to previous tab' })

set('t', '<Esc>', [[<C-\><C-n>]])
