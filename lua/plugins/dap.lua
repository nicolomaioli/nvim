local dap = require('dap')
local dapui = require('dapui')

-- Add listeners to automatically open and close dapui
dapui.setup()

dap.listeners.after.event_initialized['dapui_config'] = function()
    dapui.open({})
end
dap.listeners.before.event_terminated['dapui_config'] = function()
    dapui.close({})
end
dap.listeners.before.event_exited['dapui_config'] = function()
    dapui.close({})
end

-- vscode-js-debug (js-debug-adapter in Mason)
require('dap-vscode-js').setup({
    node_path = vim.fn.getenv('HOME') .. '/.volta/bin/node',
    debugger_path = vim.fn.stdpath('data') .. '/mason/packages/js-debug-adapter',
    debugger_cmd = { 'js-debug-adapter' },
    adapters = {
        'pwa-node',
        'pwa-chrome',
        'pwa-msedge',
        'node-terminal',
        'pwa-extensionHost',
    },
})

for _, language in ipairs({
    'typescript',
    'javascript',
    'javascriptreact',
    'typescriptreact',
}) do
    dap.configurations[language] = {
        {
            name = 'Launch Node',
            type = 'pwa-node',
            request = 'launch',
            program = '${file}',
            rootPath = '${workspaceFolder}',
            cwd = '${workspaceFolder}',
            sourceMaps = true,
            skipFiles = { '<node_internals>/**' },
            protocol = 'inspector',
            console = 'integratedTerminal',
        },
        {
            name = 'Attach Node',
            type = 'pwa-node',
            request = 'attach',
            processId = require'dap.utils'.pick_process,
            cwd = '${workspaceFolder}',
        },
        {
            name = 'Attach Chrome (port: 9222)',
            type = 'pwa-chrome',
            request = 'attach',
            program = '${file}',
            cwd = '${workspaceFolder}',
            sourceMaps = true,
            port = 9222,
            webRoot = '${workspaceFolder}',
        },
        {
            request = 'launch',
            name = 'Deno launch',
            type = 'pwa-node',
            program = '${file}',
            cwd = '${workspaceFolder}',
            runtimeExecutable = vim.fn.getenv('HOME') .. '/.deno/bin/deno',
            runtimeArgs = { 'run', '--inspect-brk', '--allow-all' },
            attachSimplePort = 9229,
        },
        {
            request = 'launch',
            name = 'Deno test launch',
            type = 'pwa-node',
            program = '${file}',
            cwd = '${workspaceFolder}',
            runtimeExecutable = vim.fn.getenv('HOME') .. '/.deno/bin/deno',
            runtimeArgs = { 'test', '--inspect-brk', '--allow-all' },
            attachSimplePort = 9229,
        },
    }
end

-- adapters
require('dap-go').setup()
require('dap-python').setup()

-- one-small-step-for-vimkind
dap.configurations.lua = {
    {
        type = 'nlua',
        request = 'attach',
        name = 'Attach to running Neovim instance',
    },
}

dap.adapters.nlua = function(callback, config)
    callback({
        type = 'server',
        host = config.host or '127.0.0.1',
        port = config.port or 8086,
    })
end

-- mappings
local load_mappings = function()
    vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint)
    vim.keymap.set('n', '<leader>dc', dap.continue)
    vim.keymap.set('n', '<leader>do', dap.step_over)
    vim.keymap.set('n', '<leader>di', dap.step_into)
    vim.keymap.set('n', '<leader>dt', dap.terminate)
    vim.keymap.set('n', '<F5>', [[:lua require"osv".launch({port = 8086})<CR>]],
                   { noremap = true })
end

load_mappings()
