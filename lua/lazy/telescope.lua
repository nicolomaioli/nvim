return {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
        { '<leader>fb', ':Telescope buffers<CR>', desc = 'Telescope buffers' },
        {
            '<leader>ff',
            ':Telescope find_files<CR>',
            desc = 'Telescope find files',
        },
        { '<leader>fg', ':Telescope live_grep<CR>',
          desc = 'Telescope live grep' },
        { '<leader>fh', ':Telescope help_tags<CR>', desc = 'Telescope vim help' },
        { '<leader>fj', ':Telescope jumplist<CR>', desc = 'Telescope jumplist' },
        { '<leader>fk', ':Telescope keymaps<CR>', desc = 'Telescope keymaps' },
        { '<leader>fm', ':Telescope marks<CR>', desc = 'Telescope marks' },
        { '<leader>fr', ':Telescope reloader<CR>', desc = 'Telescope reloader' },
        {
            '<leader>ld',
            ':Telescope diagnostics<CR>',
            desc = 'Telescope LSP diagnostics',
        },
        {
            '<leader>lr',
            ':Telescope lsp_references<CR>',
            desc = 'Telescope LSP references',
        },
        {
            '<leader>ls',
            ':Telescope lsp_document_symbols<CR>',
            desc = 'Telescope LSP sumbols',
        },
    },
    config = function()
        local telescope = require('telescope')
        local actions = require('telescope.actions')

        telescope.setup {
            pickers = {
                find_files = {
                    find_command = {
                        'rg',
                        '--files',
                        '--iglob',
                        '!.git',
                        '--hidden',
                    },
                    previewer = false,
                },
            },
            defaults = {
                mappings = {
                    i = {
                        ['<esc>'] = actions.close,
                        ['<C-d>'] = actions.delete_buffer,
                        ['<C-h>'] = actions.which_key,
                    },
                },
                vimgrep_arguments = {
                    'rg',
                    '--hidden',
                    '--glob=!.git',
                    '--color=never',
                    '--no-heading',
                    '--with-filename',
                    '--line-number',
                    '--column',
                    '--smart-case',
                },
            },
        }
    end,
}
