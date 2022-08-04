local load_mappings = function()
    vim.keymap.set('n', '<leader>gc', ':Git checkout')
    vim.keymap.set('n', '<leader>gn', ':Git checkout -b')
    vim.keymap.set('n', '<leader>gf', ':Git fetch<CR>')
    vim.keymap.set('n', '<leader>gl', ':Git pull<CR>')
    vim.keymap.set('n', '<leader>gs', ':Git<CR>')
    vim.keymap.set('n', '<leader>gp', ':Git push<CR>')
end

load_mappings()
