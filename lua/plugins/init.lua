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
        requires = {
            {'nvim-treesitter/nvim-treesitter-textobjects'},
            {'nvim-treesitter/nvim-treesitter-context'},
            {'nvim-treesitter/playground'},
        },
        run = ':TSUpdate',
        config = function()
            require('plugins.nvim-treesitter')
            require('plugins.nvim-treesitter-textobjects')
            require('plugins.nvim-treesitter-context')
        end,
    }

    use {
        'stevearc/aerial.nvim',
        config = function()
            require('plugins.aerial')
        end,
    }

    use {
        'neovim/nvim-lspconfig',
        requires = {
            -- LSP Support
            {'williamboman/mason.nvim'},
            {'williamboman/mason-lspconfig.nvim'},

            -- Neovim plugin development
            {'folke/neodev.nvim'},

            -- Autocompletion
            {'hrsh7th/nvim-cmp'},
            {'hrsh7th/cmp-buffer'},
            {'hrsh7th/cmp-path'},
            {'hrsh7th/cmp-cmdline'},
            {'hrsh7th/cmp-nvim-lsp'},
            {'hrsh7th/cmp-nvim-lua'},
            {'onsails/lspkind.nvim'},
            {'saadparwaiz1/cmp_luasnip'},

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
        requires = {'nvim-lua/plenary.nvim'},
        config = function()
            require('plugins.null-ls-nvim')
        end,
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
        requires = {
            {'rcarriga/nvim-dap-ui'},
            {'jbyuki/one-small-step-for-vimkind'},
            {'mxsdev/nvim-dap-vscode-js'},
            {'leoluz/nvim-dap-go'},
            {'mfussenegger/nvim-dap-python'},
        },
        config = function()
            require('plugins.dap')
        end,
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
            require('colorschemes.tokyonight')
        end,
    }

    use {
        'catppuccin/nvim',
        as = 'catppuccin',
        config = function()
            require('colorschemes.catppuccin')
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

    use 'nicolomaioli/wtfm.nvim'

    if bootstrap then
        require('packer').sync()
    end
end)
