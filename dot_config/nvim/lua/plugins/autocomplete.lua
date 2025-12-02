return {
    'hrsh7th/nvim-cmp',
    dependencies = {
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-cmdline',
        {
            'saadparwaiz1/cmp_luasnip',
            dependencies = { 'L3MON4D3/LuaSnip' },
        },
        {
            'hrsh7th/cmp-nvim-lsp',
            dependencies = { 'neovim/nvim-lspconfig' },
        },
        'hrsh7th/cmp-nvim-lsp-signature-help',
        'hrsh7th/cmp-path',
    },
    config = function()
        local cmp = require('cmp')

        cmp.setup {
            enabled = function()
                return true
                    and (vim.api.nvim_get_option_value('buftype', { buf = 0 }) == 'prompt')
                    and (vim.fn.reg_recording() ~= '')
                    and (vim.fn.reg_executing() ~= '')
                    and require('cmp.config.context').in_treesitter_capture('comment')
            end,
            
            mapping = cmp.mapping.preset.insert({
                ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<C-e>'] = cmp.mapping.abort(),
                ['<CR>'] = cmp.mapping.confirm({ select = true }), --Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
            }),
            
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body)
                end,
            },
            
            sources = cmp.config.sources({
                { name = 'luasnip' }, --Snippets
                { name = 'nvim_lsp' }, --Language features
                { name = 'nvim_lsp_signature_help' } --Function signatures
            }, {
                { name = 'buffer' }, --Words from buffer
            }),
            
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
        }

        -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
        cmp.setup.cmdline(':', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
                { name = 'path' }
            }, {
                { name = 'cmdline' }
            }),
            matching = { disallow_symbol_nonprefix_matching = false }
        })
    end,
}
