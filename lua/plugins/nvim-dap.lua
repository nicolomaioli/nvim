local dap = require('dap')

local load_mappings = function()
    vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint)
    vim.keymap.set('n', '<leader>dc', dap.continue)
    vim.keymap.set('n', '<leader>do', dap.step_over)
    vim.keymap.set('n', '<leader>di', dap.step_into)
    vim.keymap.set('n', '<leader>dr', function()
        dap.repl.open({}, 'vsplit')
    end)
end

load_mappings()
