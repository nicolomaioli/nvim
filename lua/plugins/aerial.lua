require('aerial').setup {
    backends = {'treesitter', 'lsp', 'markdown', 'man'},
    layout = {min_width = 30},
    on_attach = function(bufnr)
        vim.keymap.set('n', '[a', '<cmd>AerialPrev<CR>', {buffer = bufnr})
        vim.keymap.set('n', ']a', '<cmd>AerialNext<CR>', {buffer = bufnr})
    end,
    attach_mode = 'global',
    highlight_mode = 'last',
    filter_kind = false,
}

vim.keymap.set('n', '<leader>ao', '<cmd>AerialToggle!<CR>')
