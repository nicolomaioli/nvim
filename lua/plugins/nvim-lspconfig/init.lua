local lspconfig = require('lspconfig')
local cmp_nvim_lsp = require('cmp_nvim_lsp')

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = cmp_nvim_lsp.update_capabilities(capabilities)

local M = {
    ['sumneko_lua'] = require('plugins.nvim-lspconfig.lua-language-server'),
    ['tsserver'] = require('plugins.nvim-lspconfig.tsserver'),
    ['efm'] = require('plugins.nvim-lspconfig.efm-langserver'),
    ['yamlls'] = require('plugins.nvim-lspconfig.yaml-language-server'),
    ['gopls'] = require('plugins.nvim-lspconfig.gopls'),
    ['terraformls'] = require('plugins.nvim-lspconfig.terraformls'),
    ['pyright'] = require('plugins.nvim-lspconfig.pyright')
}

for k, v in pairs(M) do
    v.capabilities = capabilities
    lspconfig[k].setup(v)
end

-- Diagnostics
vim.lsp.handlers['textDocument/publishDiagnostics'] =
    vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics,
        {virtual_text = false, signs = true})

vim.fn.sign_define('LspDiagnosticsSignError',
    {text = '', texthl = 'LspDiagnosticsDefaultError'})
vim.fn.sign_define('LspDiagnosticsSignWarning',
    {text = '', texthl = 'LspDiagnosticsDefaultWarning'})
vim.fn.sign_define('LspDiagnosticsSignInformation',
    {text = '', texthl = 'LspDiagnosticsDefaultInformation'})
vim.fn.sign_define('LspDiagnosticsSignHint',
    {text = '', texthl = 'LspDiagnosticsDefaultHint'})
