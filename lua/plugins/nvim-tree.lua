require('nvim-tree').setup()

local load_mappings = function()
    vim.keymap.set('n', '<leader>kb', ':NvimTreeToggle<CR>')
end

load_mappings()
