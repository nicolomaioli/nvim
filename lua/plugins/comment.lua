return {
    'numToStr/Comment.nvim',
    event = 'BufRead',
    config = function()
        local integration = require(
            'ts_context_commentstring.integrations.comment_nvim')

        require('Comment').setup({ pre_hook = integration.create_pre_hook() })
    end,
}
