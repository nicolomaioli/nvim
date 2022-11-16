vim.api.nvim_create_autocmd({'BufRead', 'BufNewFile'}, {
    pattern = '*/waybar/config',
    callback = function()
        vim.bo.filetype = 'json'
    end,
})
