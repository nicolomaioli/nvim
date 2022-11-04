require('lualine').setup({
    options = {
        icons_enabled = true,
        theme = 'catppuccin',
        component_separators = {' ', ' '},
        section_separators = {' ', ' '},
        disabled_filetypes = {},
    },
    sections = {
        lualine_a = {'mode', 'paste'},
        lualine_b = {
            {'branch', icon = ''},
            {
                'diff',
                color_added = '#a7c080',
                color_modified = '#ffdf1b',
                color_removed = '#ff6666',
            },
        },
        lualine_c = {
            {'diagnostics', sources = {'nvim_diagnostic'}},
            function()
                return '%='
            end,
            'filename',
        },
        lualine_x = {'filetype'},
        lualine_y = {{'progress'}},
        lualine_z = {{'location', icon = ''}},
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {},
    },
    tabline = {},
    extensions = {},
})
