local cmd = vim.cmd

cmd('filetype plugin on')
cmd('syntax enable')
cmd('silent! helptags ALL')

-- Only load the theme is it's avaialbe
local colors = vim.fn.getcompletion('', 'color')
local colorscheme = 'catppuccin'

for _, v in pairs(colors) do
    if v == colorscheme then
        cmd('colorscheme ' .. colorscheme)
    end
end
