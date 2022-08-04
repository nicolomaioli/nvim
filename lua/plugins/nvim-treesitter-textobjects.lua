require'nvim-treesitter.configs'.setup {
    textobjects = {
        select = {
            enable = true,
            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,
            keymaps = {
                ['af'] = '@function.outer',
                ['if'] = '@function.inner',
                ['ac'] = '@class.outer',
                ['ic'] = '@class.inner',
                ['ak'] = '@conditional.outer',
                ['ik'] = '@conditional.inner',
                ['al'] = '@loop.outer',
                ['il'] = '@loop.inner',
                ['is'] = '@scopename.inner'
            }
        },
        swap = {
            enable = true,
            swap_next = {['<leader>sn'] = '@parameter.inner'},
            swap_previous = {['<leader>sp'] = '@parameter.inner'}
        },
        move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
                ['<leader>nf'] = '@function.outer',
                ['<leader>nc'] = '@class.outer'
            },
            goto_previous_start = {
                ['<leader>nF'] = '@function.outer',
                ['<leader>nC'] = '@class.outer'
            }
        }
    }
}
