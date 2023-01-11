return {
    'VonHeikemen/lsp-zero.nvim',
    event = 'VeryLazy',
    dependencies = {
        'neovim/nvim-lspconfig',
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        -- completion
        'hrsh7th/nvim-cmp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-cmdline',
        'saadparwaiz1/cmp_luasnip',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-nvim-lua',
        'L3MON4D3/LuaSnip',
        'rafamadriz/friendly-snippets',
        'nvim-lua/plenary.nvim',
        -- null
        'jose-elias-alvarez/null-ls.nvim',
        -- folds
        'kevinhwang91/nvim-ufo',
        'kevinhwang91/promise-async',
    },
    config = function()
        local lsp = require('lsp-zero')
        local null_ls = require('null-ls')
        local cmp = require('cmp')
        local luasnip = require('luasnip')

        -- IMPOTANT: ensure that null-ls is initialised *after* lsp-zero, otherwise it
        -- overrides a number of functions and prevents Mason to initialise properly.

        -- Declare an augroup to handle formatting on save
        local lsp_formatting_augroup = vim.api.nvim_create_augroup(
            'LspFormatting', {})

        -- The format_on_save function takes an additional format_fn, which can be
        -- overridden. In this config:
        -- * if null-ls is attached, only use null-ls to format (avoid conflicts)
        -- * otherwise use the current LSP formatting capabilities (if available)
        local format_on_save = function(client, bufnr, format_fn)
            if client.supports_method 'textDocument/formatting' then
                vim.api.nvim_clear_autocmds {
                    group = lsp_formatting_augroup,
                    buffer = bufnr,
                }
                vim.api.nvim_create_autocmd('BufWritePre', {
                    group = lsp_formatting_augroup,
                    buffer = bufnr,
                    callback = function()
                        format_fn(bufnr)
                    end,
                })
            end
        end

        -- lsp-compe Is the same as the recommended except that it assumes you want full control over the configuration for nvim-cmp
        lsp.preset('lsp-compe')

        -- folding
        lsp.set_server_config({
            capabilities = {
                textDocument = {
                    foldingRange = {
                        dynamicRegistration = false,
                        lineFoldingOnly = true,
                    },
                },
            },
        })

        lsp.configure('sumneko_lua', {
            settings = {
                Lua = {
                    diagnostics = { globals = { 'vim' } },
                    workspace = {
                        library = vim.api.nvim_get_runtime_file('', true),
                        checkThirdParty = false,
                    },
                    telemetry = { enable = false },
                },
            },
        })

        -- Use the current LSP formatting capabilities (if available) to format on save
        lsp.on_attach(function(client, bufnr)
            format_on_save(client, bufnr, function()
                vim.lsp.buf.format({ bufnr = bufnr })
            end)
        end)

        lsp.setup()

        -- folding
        require('ufo').setup()

        local select_opts = { behavior = cmp.SelectBehavior.Select }

        local has_words_before = function()
            local line, col = unpack(vim.api.nvim_win_get_cursor(0))
            return col ~= 0 and
                       vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(
                    col, col):match('%s') == nil
        end

        cmp.setup({
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            sources = {
                { name = 'path' },
                { name = 'nvim_lsp', keyword_length = 3 },
                { name = 'buffer', keyword_length = 3 },
                { name = 'luasnip', keyword_length = 2 },
            },
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
            mapping = {
                ['<Up>'] = cmp.mapping.select_prev_item(select_opts),
                ['<Down>'] = cmp.mapping.select_next_item(select_opts),

                ['<C-p>'] = cmp.mapping.select_prev_item(select_opts),
                ['<C-n>'] = cmp.mapping.select_next_item(select_opts),

                ['<C-u>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),

                ['<C-e>'] = cmp.mapping.abort(),
                ['<CR>'] = cmp.mapping.confirm({ select = true }),

                ['<C-d>'] = cmp.mapping(function(fallback)
                    if luasnip.jumpable(1) then
                        luasnip.jump(1)
                    else
                        fallback()
                    end
                end, { 'i', 's' }),

                ['<C-b>'] = cmp.mapping(function(fallback)
                    if luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { 'i', 's' }),

                ['<Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.expand_or_jumpable() then
                        luasnip.expand_or_jump()
                    elseif has_words_before() then
                        cmp.complete()
                    else
                        fallback()
                    end
                end, { 'i', 's' }),

                ['<S-Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { 'i', 's' }),
            },
        })

        cmp.setup.cmdline({ '/', '?' }, {
            mapping = cmp.mapping.preset.cmdline(),
            sources = { { name = 'buffer' } },
        })

        cmp.setup.cmdline(':', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({ { name = 'path' } },
                { { name = 'cmdline' } }),
        })

        -- If null-ls is attached, only use null-ls to format (avoid conflicts)
        local null_ls_format = function(bufnr)
            vim.lsp.buf.format({
                filter = function(client)
                    return client.name == 'null-ls'
                end,
                bufnr = bufnr,
            })
        end

        local null_opts = lsp.build_options('null-ls', {
            on_attach = function(client, bufnr)
                format_on_save(client, bufnr, null_ls_format)
            end,
        })

        null_ls.setup({
            on_attach = null_opts.on_attach,
            sources = {
                null_ls.builtins.code_actions.eslint_d.with({
                    condition = function(utils)
                        return utils.root_has_file({ 'package.json' })
                    end,
                }),
                null_ls.builtins.diagnostics.eslint_d.with({
                    condition = function(utils)
                        return utils.root_has_file({ 'package.json' })
                    end,
                }),
                null_ls.builtins.formatting.eslint_d.with({
                    condition = function(utils)
                        return utils.root_has_file({ 'package.json' })
                    end,
                }),
                null_ls.builtins.formatting.prettierd.with({
                    filetypes = {
                        'markdown',
                        'html',
                        'json',
                        'jsonc',
                        'javascript',
                        'javascriptreact',
                        'typescript',
                        'typescriptreact',
                    },
                    condition = function(utils)
                        return utils.root_has_file({ 'package.json' })
                    end,
                }),
                null_ls.builtins.formatting.lua_format,
                null_ls.builtins.formatting.rustfmt,
            },
        })

        vim.o.foldcolumn = '0'
        vim.o.foldlevel = 99
        vim.o.foldlevelstart = 99
        vim.o.foldenable = true

        -- Using ufo provider need remap `zR` and `zM`
        vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
        vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
    end,
}
