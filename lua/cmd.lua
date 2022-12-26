local cmd = vim.cmd
local api = vim.api

cmd('filetype plugin on')
cmd('syntax enable')
cmd('silent! helptags ALL')

-- Only load the theme is it's avaialbe
local colors = vim.fn.getcompletion('', 'color')
local colorscheme = 'solarized-flat'

for _, v in pairs(colors) do
    if v == colorscheme then
        cmd.colorscheme(colorscheme)
    end
end

-- Set transparent background in the terminal
if (vim.fn.has('gui_running') == 0) then
    api.nvim_set_hl(0, 'Normal', { bg = 'none' })
    api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
end
