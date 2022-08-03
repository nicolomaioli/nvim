local lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp
                                                                     .protocol
                                                                     .make_client_capabilities())

local M = {
    ['sumneko_lua'] = require('plugins.nvim-lspconfig.lua-language-server'),
    ['efm'] = require('plugins.nvim-lspconfig.efm-langserver')
}

for k, v in pairs(M) do
    v.capabilities = capabilities
    lspconfig[k].setup(v)
end
