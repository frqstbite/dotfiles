return {
	'mason-org/mason-lspconfig.nvim',
	dependencies = {'mason-org/mason.nvim', 'neovim/nvim-lspconfig'},
	opts = {
		automatic_enable = true,
		ensure_installed = {
			'astro',
			'bashls',
			'biome',
			'cmake',
			'csharp_ls',
			'css_variables',
			'cssls',
			'cssmodules_ls',
			'dotls',
			'eslint',
			'gh_actions_ls',
			'glsl_analyzer',
			'gradle_ls',
			'html',
			'jsonls',
			'luau_lsp',
			'markdown_oxide',
			'mdx_analyzer',
			'pylsp',
			'rust_analyzer',
			'spyglassmc_language_server',
			'stylua',
			'systemd_ls',
			'ts_ls',
			'vue_ls',
			'yamlls',
		},
        handlers = {
            function(server_name)
                vim.lsp.config(server_name, {
                    capabilities = require('cmp_nvim_lsp').default_capabilities(),
                })
            end,
        },
	},
}
