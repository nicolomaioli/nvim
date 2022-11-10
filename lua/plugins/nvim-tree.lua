require('nvim-tree').setup({
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
    if vim.g.neovide then
        vim.keymap.set('n', '<C-/>', ':NvimTreeToggle<CR>')
    else
        vim.keymap.set('n', '<leader>kb', ':NvimTreeToggle<CR>')
    end
end

load_mappings()
