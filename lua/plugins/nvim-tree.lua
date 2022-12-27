local set = vim.keymap.set

require('nvim-tree').setup({
    git = { ignore = false },
    view = {
        adaptive_size = false,
        centralize_selection = false,
        width = 30,
        hide_root_folder = false,
        side = 'left',
        preserve_window_proportions = false,
        number = false,
        relativenumber = false,
        signcolumn = 'yes',
        mappings = { custom_only = false },
    },
})

if vim.g.neovide then
    set('n', '<C-/>', ':NvimTreeToggle<CR>', { desc = 'Toggle NvimTree' })
else
    set('n', '<leader>kb', ':NvimTreeToggle<CR>', { desc = 'Toggle NvimTree' })
end
