local M = {
    on_attach = function(client)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
    end,
    settings = {
        yaml = {
            customTags = {
                '!fn',
                '!And',
                '!And sequence',
                '!If',
                '!If sequence',
                '!Not',
                '!Not sequence',
                '!Equals',
                '!Equals sequence',
                '!Or',
                '!Or sequence',
                '!FindInMap',
                '!FindInMap sequence',
                '!Base64',
                '!Join',
                '!Join sequence',
                '!Cidr',
                '!Ref',
                '!Sub',
                '!Sub sequence',
                '!GetAtt',
                '!GetAZs',
                '!ImportValue',
                '!ImportValue sequence',
                '!Select',
                '!Select sequence',
                '!Split',
                '!Split sequence',
            },
        },
    },
}

return M
