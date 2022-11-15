local set = vim.keymap.set

set('n', '<leader>sd', ':let @/=""<CR>')
set('n', '<leader>sr', ':%s/')
set('n', '<leader>xx', ':source %<CR>')
set('n', '<leader>cl', ':close<CR>')

set('n', '<leader>wh', '<C-w>h')
set('n', '<leader>wj', '<C-w>j')
set('n', '<leader>wk', '<C-w>k')
set('n', '<leader>wl', '<C-w>l')

local tabedit_with_curpos = function()
    -- Wraps tabedit to retain cursor position
    local curpos = vim.fn.getpos('.')
    vim.cmd [[tabedit %]]
    vim.fn.setpos('.', curpos)
end

set('n', '<leader>te', tabedit_with_curpos)
set('n', '<leader>tc', ':tabclose<CR>')
set('n', '<leader>tn', ':tabnext<CR>')
set('n', '<leader>tp', ':tabprevious<CR>')

set('t', '<Esc>', [[<C-\><C-n>]])
