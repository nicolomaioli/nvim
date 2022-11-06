local set = vim.keymap.set

set('n', '<leader>sd', ':let @/=""<CR>')
set('n', '<leader>sr', ':%s/')
set('n', '<leader>xx', ':source %<CR>')
set('n', '<leader>cl', ':close<CR>')

set('n', '<leader>wh', '<C-w>h')
set('n', '<leader>wj', '<C-w>j')
set('n', '<leader>wk', '<C-w>k')
set('n', '<leader>wl', '<C-w>l')

set('t', '<Esc>', [[<C-\><C-n>]])

local reload = function()
    vim.ui.input({prompt = 'Reload package:'}, function(input)
        for k in pairs(package.loaded) do
            if k:match(input) then
                package.loaded[k] = nil
                print(k .. ' reloaded')
            end
        end
    end)
end

set('n', '<leader>pra', reload)
