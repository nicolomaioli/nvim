return {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v2.x',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-tree/nvim-web-devicons',
        'MunifTanjim/nui.nvim',
    },
    keys = {
        { '<leader>kk', ':Neotree toggle focus<CR>', desc = 'Toggle Neotree' },
        {
            '<leader>kb',
            ':Neotree toggle buffers focus<CR>',
            desc = 'Toggle Neotree buffers',
        },
        { '<C-/>', ':Neotree toggle focus<CR>', desc = 'Toggle Neotree' },
    },
    config = function()
        -- Unless you are still migrating, remove the deprecated commands from v1.x
        vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

        -- If you want icons for diagnostic errors, you'll need to define them somewhere:
        vim.fn.sign_define('DiagnosticSignError',
            { text = ' ', texthl = 'DiagnosticSignError' })
        vim.fn.sign_define('DiagnosticSignWarn',
            { text = ' ', texthl = 'DiagnosticSignWarn' })
        vim.fn.sign_define('DiagnosticSignInfo',
            { text = ' ', texthl = 'DiagnosticSignInfo' })
        vim.fn.sign_define('DiagnosticSignHint',
            { text = '', texthl = 'DiagnosticSignHint' })

        require('neo-tree').setup({
            close_if_last_window = true,
            popup_border_style = 'rounded',
            enable_git_status = true,
            enable_diagnostics = true,
            sort_case_insensitive = false,
            sort_function = nil,
            default_component_configs = {
                container = { enable_character_fade = true },
                indent = {
                    indent_size = 2,
                    with_markers = true,
                    indent_marker = '│',
                    last_indent_marker = '└',
                    highlight = 'NeoTreeIndentMarker',
                    with_expanders = nil,
                    expander_collapsed = '',
                    expander_expanded = '',
                    expander_highlight = 'NeoTreeExpander',
                },
                icon = {
                    folder_closed = '',
                    folder_open = '',
                    folder_empty = '',
                    default = '*',
                    highlight = 'NeoTreeFileIcon',
                },
                modified = { symbol = '[+]', highlight = 'NeoTreeModified' },
                name = {
                    trailing_slash = false,
                    use_git_status_colors = true,
                    highlight = 'NeoTreeFileName',
                },
                git_status = {
                    symbols = {
                        added = '',
                        modified = '',
                        deleted = '✖',
                        renamed = '',
                        untracked = '',
                        ignored = '',
                        unstaged = '',
                        staged = '',
                        conflict = '',
                    },
                },
            },
            window = {
                position = 'left',
                width = 30,
                mapping_options = { noremap = true, nowait = true },
                mappings = {
                    ['<space>'] = { 'toggle_node', nowait = false },
                    ['<2-LeftMouse>'] = 'open',
                    ['<cr>'] = 'open',
                    ['<esc>'] = 'revert_preview',
                    ['P'] = { 'toggle_preview', config = { use_float = true } },
                    ['S'] = 'open_split',
                    ['s'] = 'open_vsplit',
                    ['t'] = 'open_tabnew',
                    ['w'] = 'open_with_window_picker',
                    ['C'] = 'close_node',
                    ['z'] = 'close_all_nodes',
                    ['a'] = { 'add', config = { show_path = 'none' } },
                    ['A'] = 'add_directory',
                    ['d'] = 'delete',
                    ['r'] = 'rename',
                    ['y'] = 'copy_to_clipboard',
                    ['x'] = 'cut_to_clipboard',
                    ['p'] = 'paste_from_clipboard',
                    ['c'] = 'copy',
                    ['m'] = 'move',
                    ['q'] = 'close_window',
                    ['R'] = 'refresh',
                    ['?'] = 'show_help',
                    ['<'] = 'prev_source',
                    ['>'] = 'next_source',
                },
            },
            nesting_rules = {},
            filesystem = {
                filtered_items = {
                    visible = false,
                    hide_dotfiles = false,
                    hide_gitignored = false,
                    hide_hidden = false,
                },
                follow_current_file = true,
                group_empty_dirs = false,
                hijack_netrw_behavior = 'open_default',
                use_libuv_file_watcher = false,
                window = {
                    mappings = {
                        ['<bs>'] = 'navigate_up',
                        ['.'] = 'set_root',
                        ['H'] = 'toggle_hidden',
                        ['/'] = 'fuzzy_finder',
                        ['D'] = 'fuzzy_finder_directory',
                        ['f'] = 'filter_on_submit',
                        ['<c-x>'] = 'clear_filter',
                        ['[g'] = 'prev_git_modified',
                        [']g'] = 'next_git_modified',
                    },
                },
            },
            buffers = {
                follow_current_file = true,
                group_empty_dirs = true,
                show_unloaded = true,
                window = {
                    mappings = {
                        ['bd'] = 'buffer_delete',
                        ['<bs>'] = 'navigate_up',
                        ['.'] = 'set_root',
                    },
                },
            },
            git_status = {
                window = {
                    position = 'float',
                    mappings = {
                        ['A'] = 'git_add_all',
                        ['gu'] = 'git_unstage_file',
                        ['ga'] = 'git_add_file',
                        ['gr'] = 'git_revert_file',
                        ['gc'] = 'git_commit',
                        ['gp'] = 'git_push',
                        ['gg'] = 'git_commit_and_push',
                    },
                },
            },
        })
    end,
}
