require('gui')
require('g')
require('opt')
require('keymaps')
require('cmd')

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        '--single-branch',
        'https://github.com/folke/lazy.nvim.git',
        lazypath,
    })
end

vim.opt.runtimepath:prepend(lazypath)
require('lazy').setup('lazy', { change_detection = { enabled = false } })
