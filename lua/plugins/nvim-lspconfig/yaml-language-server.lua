local M = {
    on_attach = function(client)
        client.resolved_capabilities.document_formatting = false
        client.resolved_capabilities.document_range_formatting = false
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
