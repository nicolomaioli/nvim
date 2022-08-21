require('nvim-tree').setup({git = {ignore = false}})

local load_mappings = function()
    vim.keymap.set('n', '<leader>kb', ':NvimTreeToggle<CR>')
end

load_mappings()
