local lspconfig = require('lspconfig')
local cmp_nvim_lsp = require('cmp_nvim_lsp')

local capabilities = cmp_nvim_lsp.default_capabilities()

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
    v.capabilities = capabilities
    lspconfig[k].setup(v)
end

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
