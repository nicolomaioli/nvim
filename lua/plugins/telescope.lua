local telescope = require('telescope')
local builtin = require('telescope.builtin')
local actions = require('telescope.actions')
local set = vim.keymap.set

telescope.setup {
    pickers = {
        find_files = {
            find_command = { 'rg', '--files', '--iglob', '!.git', '--hidden' },
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

set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope vim help' })
set('n', '<leader>fj', builtin.jumplist, { desc = 'Telescope jumplist' })
set('n', '<leader>fk', builtin.keymaps, { desc = 'Telescope keymaps' })
set('n', '<leader>fm', builtin.marks, { desc = 'Telescope marks' })
set('n', '<leader>fr', builtin.reloader, { desc = 'Telescope reloader' })
set('n', '<leader>ld', builtin.diagnostics,
    { desc = 'Telescope LSP diagnostics' })
set('n', '<leader>lr', builtin.lsp_references,
    { desc = 'Telescope LSP references' })
set('n', '<leader>ls', builtin.lsp_document_symbols,
    { desc = 'Telescope LSP sumbols' })
