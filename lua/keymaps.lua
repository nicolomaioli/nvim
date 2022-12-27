local set = vim.keymap.set

set('n', '<leader>sd', ':let @/=""<CR>', { desc = 'Clear last register' })
set('n', '<leader>sr', ':%s/', { desc = 'Search and replace' })
set('n', '<leader>cl', ':close<CR>', { desc = 'Close buffer' })

set('n', '<leader>wh', '<C-w>h', { desc = 'Move to window left' })
set('n', '<leader>wj', '<C-w>j', { desc = 'Move to window down' })
set('n', '<leader>wk', '<C-w>k', { desc = 'Move to window up' })
set('n', '<leader>wl', '<C-w>l', { desc = 'Move to window right' })

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
