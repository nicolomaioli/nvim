return {
    'lukas-reineke/indent-blankline.nvim',
    event = 'BufReadPre',
    init = function()
        vim.g.indent_blankline_char = '▎'
        vim.g.indent_blankline_char_blankline = '▎'
    end,
    opts = {
        filetype_exclude = {
            'NeogitStatus',
            'TelescopePrompt',
            'TelescopeResults',
            'checkhealth',
            'diagnosticpopup',
            'gitmessengerpopup',
            'help',
            'lazy',
            'lspinfo',
            'man',
            'mason',
            'neo-tree',
            'neotest-summary',
        },
        buftype_exclude = { 'terminal' },
        show_trailing_blankline_indent = false,
        space_char_blankline = ' ',
        show_foldtext = false,
        strict_tabs = true,
        max_indent_increase = 1,
        show_current_context = true,
        show_current_context_start = false,
        viewport_buffer = 100,
    },
}
