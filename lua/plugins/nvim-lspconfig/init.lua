local lspconfig = require('lspconfig')
local cmp_nvim_lsp = require('cmp_nvim_lsp')
local lspconfig_defaults = lspconfig.util.default_config

lspconfig_defaults.capabilities = vim.tbl_deep_extend('force',
    lspconfig_defaults.capabilities, cmp_nvim_lsp.default_capabilities())

local M = {
    ['dockerls'] = require('plugins.nvim-lspconfig.docker-language-server'),
    ['ansiblels'] = require('plugins.nvim-lspconfig.ansible-language-server'),
    ['gopls'] = require('plugins.nvim-lspconfig.gopls'),
    ['pyright'] = require('plugins.nvim-lspconfig.pyright'),
    ['sumneko_lua'] = require('plugins.nvim-lspconfig.lua-language-server'),
    ['terraformls'] = require('plugins.nvim-lspconfig.terraform-ls'),
    ['tsserver'] = require('plugins.nvim-lspconfig.tsserver'),
    ['yamlls'] = require('plugins.nvim-lspconfig.yaml-language-server'),
}

for k, v in pairs(M) do
    lspconfig[k].setup(v)
end

vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'LSP actions',
    callback = function()
        local bufmap = function(mode, lhs, rhs)
            local opts = {buffer = true}
            vim.keymap.set(mode, lhs, rhs, opts)
        end

        bufmap('n', 'K', vim.lsp.buf.hover)
        bufmap('n', 'gd', vim.lsp.buf.definition)
        bufmap('n', 'gD', vim.lsp.buf.declaration)
        bufmap('n', 'gi', vim.lsp.buf.implementation)
        bufmap('n', 'go', vim.lsp.buf.type_definition)
        bufmap('n', 'gr', vim.lsp.buf.references)
        bufmap('n', '<C-k>', vim.lsp.buf.signature_help)
        bufmap('n', '<F2>', vim.lsp.buf.rename)
        bufmap('n', '<F4>', vim.lsp.buf.code_action)
        bufmap('x', '<F4>', vim.lsp.buf.range_code_action)
        bufmap('n', 'gl', vim.diagnostic.open_float)
        bufmap('n', '[d', vim.diagnostic.goto_prev)
        bufmap('n', ']d', vim.diagnostic.goto_next)
    end,
})

local load_diagnostics = function()
    -- Diagnostics
    vim.lsp.handlers['textDocument/publishDiagnostics'] =
        vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics,
            {virtual_text = false, signs = true})

    vim.fn.sign_define('LspDiagnosticsSignError',
        {text = '', texthl = 'LspDiagnosticsDefaultError'})
    vim.fn.sign_define('LspDiagnosticsSignWarning',
        {text = '', texthl = 'LspDiagnosticsDefaultWarning'})
    vim.fn.sign_define('LspDiagnosticsSignInformation', {
        text = '',
        texthl = 'LspDiagnosticsDefaultInformation',
    })
    vim.fn.sign_define('LspDiagnosticsSignHint',
        {text = '', texthl = 'LspDiagnosticsDefaultHint'})
end

load_diagnostics()
