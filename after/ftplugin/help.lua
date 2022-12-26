vim.api.nvim_create_autocmd('BufWinEnter', {
    buffer = 0,
    command = [[ :wincmd L | :vert resize 80 ]]
})
