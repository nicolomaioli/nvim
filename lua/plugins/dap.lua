local dap = require('dap')
local dapui = require('dapui')

dapui.setup()

-- Add listeners to automatically open and close dapui
dap.listeners.after.event_initialized['dapui_config'] = function()
    dapui.open({})
end
dap.listeners.before.event_terminated['dapui_config'] = function()
    dapui.close({})
end
dap.listeners.before.event_exited['dapui_config'] = function()
    dapui.close({})
end

require('dap-go').setup()
require('dap-python').setup()

local load_mappings = function()
    vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint)
    vim.keymap.set('n', '<leader>dc', dap.continue)
    vim.keymap.set('n', '<leader>do', dap.step_over)
    vim.keymap.set('n', '<leader>di', dap.step_into)
    vim.keymap.set('n', '<leader>dt', dap.terminate)
end

load_mappings()
