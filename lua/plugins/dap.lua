return {
    'mfussenegger/nvim-dap',
    keys = {
        { '<F5>', ':DapContinue<CR>', desc = 'Debug continue' },
        {
            '<leader>db',
            ':DapToggleBreakpoint<CR>',
            desc = 'Debug toggle breakpoint',
        },
        { '<leader>do', ':DapStepOut<CR>', desc = 'Debug step out' },
        { '<leader>dv', ':DapStepOver<CR>', desc = 'Debug step over' },
        { '<leader>di', ':DapStepInto<CR>', desc = 'Debug step into' },
        { '<leader>dt', ':DapTerminate<CR>', desc = 'Debug terminate' },
    },
    dependencies = { 'rcarriga/nvim-dap-ui', 'mxsdev/nvim-dap-vscode-js' },
    config = function()
        local dap = require('dap')
        local dapui = require('dapui')
        local utils = require('dap.utils')

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
            debugger_path = vim.fn.stdpath('data') ..
                '/mason/packages/js-debug-adapter',
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
                    name = 'Launch Next',
                    type = 'pwa-node',
                    request = 'launch',
                    env = { NODE_OPTIONS = '--inspect' },
                    runtimeExecutable = 'npm',
                    runtimeArgs = { 'run', 'dev' },
                    rootPath = '${workspaceFolder}',
                    cwd = '${workspaceFolder}',
                    console = 'integratedTerminal',
                    internalConsoleOptions = 'neverOpen',
                },
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
                    processId = utils.pick_process,
                    cwd = '${workspaceFolder}',
                },
                {
                    name = 'Launch Chrome',
                    type = 'pwa-chrome',
                    request = 'launch',
                    url = 'http://localhost:3000',
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
                    runtimeExecutable = vim.fn.getenv('HOME') ..
                        '/.deno/bin/deno',
                    runtimeArgs = { 'run', '--inspect-brk', '--allow-all' },
                    attachSimplePort = 9229,
                },
                {
                    request = 'launch',
                    name = 'Deno test launch',
                    type = 'pwa-node',
                    program = '${file}',
                    cwd = '${workspaceFolder}',
                    runtimeExecutable = vim.fn.getenv('HOME') ..
                        '/.deno/bin/deno',
                    runtimeArgs = { 'test', '--inspect-brk', '--allow-all' },
                    attachSimplePort = 9229,
                },
            }
        end

        vim.keymap.set('n', '<leader>dc', dapui.close, { desc = 'Dapui close' })
    end,
}
