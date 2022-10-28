require('nvim-tree').setup({
    open_on_setup = true,
    git = {ignore = false},
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
        mappings = {custom_only = false},
    },
})

local load_mappings = function()
    vim.keymap.set('n', '<leader>kb', ':NvimTreeToggle<CR>')
end

load_mappings()
