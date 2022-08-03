local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
    Bootstrap = fn.system({
        'git', 'clone', '--depth', '1',
        'https://github.com/wbthomason/packer.nvim', install_path
    })
    vim.o.runtimepath = vim.fn.stdpath('data') .. '/site/pack/*/start/*,'
                            .. vim.o.runtimepath
end

vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    use {
        'nvim-telescope/telescope.nvim',
        requires = {'nvim-lua/plenary.nvim'},
        config = require('plugins.telescope')
    }

    use {
        'kyazdani42/nvim-tree.lua',
        requires = {'kyazdani42/nvim-web-devicons'},
        tag = 'nightly',
        config = require('plugins.nvim-tree')
    }

    -- use {
        -- 'hrsh7th/nvim-cmp',
        -- requires = {
            -- {'hrsh7th/cmp-nvim-lsp', after = 'nvim-cmp'},
            -- {'hrsh7th/cmp-path', after = 'nvim-cmp'},
            -- {'hrsh7th/cmp-buffer', after = 'nvim-cmp'},
            -- {'hrsh7th/cmp-cmdline', after = 'nvim-cmp'}
        -- },
        -- config = require('plugins.nvim-cmp')
    -- }

    use {
        'neovim/nvim-lspconfig',
        requires = {'hrsh7th/nvim-cmp'},
        config = require('plugins.nvim-lspconfig')
    }

    use 'tpope/vim-commentary'
    use 'tpope/vim-fugitive'
    use 'tpope/vim-surround'

    use {'dracula/vim', as = 'dracula'}
    use {'hoob3rt/lualine.nvim', config = require('plugins.lualine')}
    use {'windwp/nvim-autopairs', config = require('plugins.nvim-autopairs')}

    if Bootstrap then require('packer').sync() end
end)
