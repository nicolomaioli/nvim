local fn = vim.fn
local install_path =
    fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
local bootstrap = nil

if fn.empty(fn.glob(install_path)) > 0 then
    bootstrap = fn.system({
        'git',
        'clone',
        '--depth',
        '1',
        'https://github.com/wbthomason/packer.nvim',
        install_path,
    })
    vim.o.runtimepath = vim.fn.stdpath('data') .. '/site/pack/*/start/*,'
                            .. vim.o.runtimepath
end

vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = function()
            require('plugins.nvim-treesitter')
        end,
    }

    use {
        'nvim-treesitter/nvim-treesitter-textobjects',
        config = function()
            require('plugins.nvim-treesitter-textobjects')
        end,
    }

    use 'nvim-treesitter/playground'

    use {
        'stevearc/aerial.nvim',
        config = function()
            require('plugins.aerial')
        end,
    }

    use {
        'VonHeikemen/lsp-zero.nvim',
        requires = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},
            {'williamboman/mason.nvim'},
            {'williamboman/mason-lspconfig.nvim'},

            -- Autocompletion
            {'hrsh7th/nvim-cmp'},
            {'hrsh7th/cmp-buffer'},
            {'hrsh7th/cmp-path'},
            {'saadparwaiz1/cmp_luasnip'},
            {'hrsh7th/cmp-nvim-lsp'},
            {'hrsh7th/cmp-nvim-lua'},

            -- Snippets
            {'L3MON4D3/LuaSnip'},
            {'rafamadriz/friendly-snippets'},
        },
        config = function()
            require('plugins.lsp')
        end,
    }

    use {
        'jose-elias-alvarez/null-ls.nvim',
        config = function()
            require('plugins.null-ls-nvim')
        end,
        requires = {'nvim-lua/plenary.nvim'},
    }

    use {
        'nvim-telescope/telescope.nvim',
        requires = {'nvim-lua/plenary.nvim'},
        config = function()
            require('plugins.telescope')
        end,
    }

    use {
        'mfussenegger/nvim-dap',
        config = function()
            require('plugins.nvim-dap')
        end,
    }

    use {
        'rcarriga/nvim-dap-ui',
        requires = {'mfussenegger/nvim-dap'},
        config = function()
            require('plugins.nvim-dap.nvim-dap-ui')
        end,
    }

    use {
        'leoluz/nvim-dap-go',
        requires = {'mfussenegger/nvim-dap'},
        config = function()
            require('plugins.nvim-dap.nvim-dap-go')
        end,
        ft = 'go',
    }

    use {
        'mfussenegger/nvim-dap-python',
        requires = {'mfussenegger/nvim-dap'},
        config = function()
            require('plugins.nvim-dap.nvim-dap-python')
        end,
        ft = 'python',
    }

    use {
        'kyazdani42/nvim-tree.lua',
        requires = {'kyazdani42/nvim-web-devicons'},
        tag = 'nightly',
        config = function()
            require('plugins.nvim-tree')
        end,
    }

    use {
        'lewis6991/gitsigns.nvim',
        config = function()
            require('plugins.gitsigns-nvim')
        end,
    }

    use 'pearofducks/ansible-vim'

    use 'tpope/vim-commentary'

    use 'tpope/vim-surround'

    use {
        'tpope/vim-fugitive',
        config = function()
            require('plugins.vim-fugitive')
        end,
    }

    use {
        'folke/tokyonight.nvim',
        config = function()
            require('plugins.tokyonight')
        end,
    }

    use {
        'nvim-lualine/lualine.nvim',
        config = function()
            require('plugins.lualine')
        end,
    }

    use {
        'windwp/nvim-autopairs',
        config = function()
            require('plugins.nvim-autopairs')
        end,
    }

    use {
        'akinsho/toggleterm.nvim',
        tag = '*',
        config = function()
            require('plugins.toggleterm-nvim')
        end,
    }

    if bootstrap then
        require('packer').sync()
    end
end)
