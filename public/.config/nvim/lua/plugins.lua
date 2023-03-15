local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
	packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

return require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'

	use 'RRethy/nvim-base16'
	vim.cmd.colorscheme('base16-tomorrow-night')

	use {
		'lewis6991/gitsigns.nvim',
		tag = 'release',
		config = function()
			require('gitsigns').setup()
		end
	}

	use {
		'nvim-telescope/telescope.nvim',
		requires = { {'nvim-lua/plenary.nvim'} }
	}
	vim.api.nvim_set_keymap(
		'n',
		'<C-P>',
		':Telescope find_files find_command=rg,--ignore,--hidden,-g,!.git/,--files<CR>',
		{}
	)
	vim.api.nvim_set_keymap(
		'n',
		'<Leader>fiw',
		':Telescope grep_string<CR>',
		{}
	)
	vim.api.nvim_set_keymap(
		'n',
		'<Leader>ff',
		':Telescope live_grep<CR>',
		{}
	)

	use 'numToStr/Comment.nvim'
	require('Comment').setup()

	use 'windwp/nvim-autopairs'
	require('nvim-autopairs').setup{}

	use 'tpope/vim-vinegar'

	use 'github/copilot.vim'
	vim.api.nvim_set_keymap(
		'i',
		'<S-Tab>',
		'copilot#Accept("")',
		{ silent = true, script = true, expr = true }
	)
	vim.g.copilot_no_tab_map = true

	use 'RRethy/vim-illuminate'

	use 'lukas-reineke/indent-blankline.nvim'

	use 'tpope/vim-sleuth'

	use 'ethanholz/nvim-lastplace'

	use 'leafOfTree/vim-svelte-plugin'

	use 'dense-analysis/ale'
	vim.g.ale_fixers = {
		['*'] = {'remove_trailing_lines', 'trim_whitespace'},
		['javascript'] = {'eslint'},
		['typescript'] = {'eslint'},
		['javascriptreact'] = {'eslint'},
		['typescriptreact'] = {'eslint'},
		['go'] = {'gofmt'},
		['rust'] = {'rustfmt'}
	}
	vim.g.ale_rust_rustfmt_options = '--edition 2021' -- see https://www.reddit.com/r/rust/comments/mbhemw/soved_my_rust_format_problem_in_vim_and_ale/
	vim.g.ale_fix_on_save = 1

	use 'neovim/nvim-lspconfig'

	use 'hrsh7th/cmp-nvim-lsp'
	use 'hrsh7th/cmp-path'
	use 'hrsh7th/nvim-cmp'

	use 'hrsh7th/cmp-vsnip'
	use 'hrsh7th/vim-vsnip'


	local cmp = require'cmp'
	cmp.setup({
		snippet = {
			expand = function(args)
				vim.fn['vsnip#anonymous'](args.body)
			end,
		},
		mapping = cmp.mapping.preset.insert({
			['<CR>'] = cmp.mapping.confirm({ select = true }),
		}),
		sources = cmp.config.sources({
			{ name = 'nvim_lsp' },
			{ name = 'path' }
		}),
	})

	local on_attach = function(client, bufnr)
		vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
		vim.keymap.set('n', '<Leader>rn', vim.lsp.buf.rename, bufopts)
	end

	local capabilities = require('cmp_nvim_lsp').default_capabilities()

	local lspconfig = require('lspconfig')

	local servers = { 'tsserver', 'gopls' }
	for _, lsp in ipairs(servers) do
		lspconfig[lsp].setup {
			on_attach = on_attach,
			capabilities = capabilities,
		}
	end

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if packer_bootstrap then
		require('packer').sync()
	end
end)
