return {
	'rshkarin/mason-nvim-lint',
	opts = {
		automatic_installation = false,
        'cmakelint',
		'cpplint',
		'eslint_d',
		'gitlint',
		'jsonlint',
		'luacheck',
		'markdownlint',
        'selene',
		'shellcheck',
		'stylelint',
	    'vint',
		'yamllint',
    },
	dependencies = {'mason-org/mason.nvim', 'mfussenegger/nvim-lint'},
}
