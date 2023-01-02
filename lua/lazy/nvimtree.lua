return {
    'kyazdani42/nvim-tree.lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    keys = {
        { '<leader>kb', ':NvimTreeToggle<CR>', desc = 'Toggle NvimTree' },
        { '<C-/>', ':NvimTreeToggle<CR>', desc = 'Toggle NvimTree' },
    },
    tag = 'nightly',
    config = {
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
    },
}
