local telescope = require('telescope')
local builtin = require('telescope.builtin')
local actions = require('telescope.actions')

telescope.setup {
    pickers = {
        find_files = {
            find_command = {'rg', '--files', '--iglob', '!.git', '--hidden'},
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
            'rg', '--hidden', '--glob=!.git', '--color=never', '--no-heading',
            '--with-filename', '--line-number', '--column', '--smart-case',
        },
    },
}

local load_mappings = function()
    vim.keymap.set('n', '<leader>fb', builtin.buffers)
    vim.keymap.set('n', '<leader>ff', builtin.find_files)
    vim.keymap.set('n', '<leader>fg', builtin.live_grep)
    vim.keymap.set('n', '<leader>fh', builtin.help_tags)
    vim.keymap.set('n', '<leader>fj', builtin.jumplist)
    vim.keymap.set('n', '<leader>fk', builtin.keymaps)
    vim.keymap.set('n', '<leader>fm', builtin.marks)
    vim.keymap.set('n', '<leader>fr', builtin.reloader)

    -- lsp
    vim.keymap.set('n', '<leader>ld', builtin.diagnostics)
    vim.keymap.set('n', '<leader>lr', builtin.lsp_references)
    vim.keymap.set('n', '<leader>ls', builtin.lsp_document_symbols)
end

load_mappings()
