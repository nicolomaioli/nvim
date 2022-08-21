local cmd = vim.cmd

cmd('filetype plugin on')
cmd('syntax enable')
cmd('silent! helptags ALL')

-- Only load the theme is it's avaialbe
local colors = vim.fn.getcompletion('', 'color')
local theme = 'dracula'

for _, v in pairs(colors) do
    if v == theme then
        cmd('colorscheme ' .. theme)
    end
end
