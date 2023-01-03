return {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    dependencies = {
        'nvim-treesitter/nvim-treesitter-textobjects',
        'nvim-treesitter/playground',
    },
    build = ':TSUpdate',
    config = function()
        local treesitter = require('nvim-treesitter.configs')

        -- Here's a fun gotcha:
        -- This module is called 'nvim-treesitter/nvim-treesitter', so if you
        -- pass a table to config lazy.nvim calls require('nvim-treesitter').setup(table).
        -- However, in the specific case of tree-sitter it should be require('nvim-treesitter.configs').setup(table).
        -- And that's why we need to call it in a function.

        treesitter.setup({
            ensure_installed = { 'lua', 'vim' },
            auto_install = true,
            highlight = { enable = true },
            indent = { enable = true },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = '<c-space>',
                    node_incremental = '<c-space>',
                    scope_incremental = '<c-s>',
                    node_decremental = '<c-backspace>',
                },
            },
            textobjects = {
                select = {
                    enable = true,
                    -- Automatically jump forward to textobj, similar to targets.vim
                    lookahead = true,
                    keymaps = {
                        ['af'] = '@function.outer',
                        ['if'] = '@function.inner',
                        ['ak'] = '@class.outer',
                        ['ik'] = '@class.inner',
                        ['ac'] = '@conditional.outer',
                        ['ic'] = '@conditional.inner',
                        ['al'] = '@loop.outer',
                        ['il'] = '@loop.inner',
                        ['as'] = '@scopename.outer',
                        ['is'] = '@scopename.inner',
                    },
                },
                swap = {
                    enable = true,
                    swap_next = { ['<leader>sn'] = '@parameter.inner' },
                    swap_previous = { ['<leader>sp'] = '@parameter.inner' },
                },
                move = {
                    enable = true,
                    set_jumps = true,
                    goto_next_start = {
                        ['<leader>nf'] = '@function.outer',
                        ['<leader>nc'] = '@class.outer',
                    },
                    goto_previous_start = {
                        ['<leader>nF'] = '@function.outer',
                        ['<leader>nC'] = '@class.outer',
                    },
                },
            },
            playground = {
                enable = true,
                disable = {},
                updatetime = 25,
                persist_queries = false,
                keybindings = {
                    init_selection = 'gnn',
                    node_incremental = 'grn',
                    scope_incremental = 'grc',
                    node_decremental = 'grm',
                    toggle_query_editor = 'o',
                    toggle_hl_groups = 'i',
                    toggle_injected_languages = 't',
                    toggle_anonymous_nodes = 'a',
                    toggle_language_display = 'I',
                    focus_language = 'f',
                    unfocus_language = 'F',
                    update = 'R',
                    goto_node = '<cr>',
                    show_help = '?',
                },
            },
        })
    end,
}
