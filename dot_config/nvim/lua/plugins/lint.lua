return {
	'rshkarin/mason-nvim-lint',
	opts = {
		'cmakelint',
		'cpplint',
		'eslint_d',
		'gitlint',
		'jsonlint',
		'luacheck',
		'markdownlint',
		'shellcheck',
		'stylelint',
		'vint',
		'yamllint',
	},
	dependencies = {'mason-org/mason.nvim', 'mfussenegger/nvim-lint'},
}
