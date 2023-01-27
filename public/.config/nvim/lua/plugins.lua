local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
	packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

return require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'

	use 'RRethy/nvim-base16'
	local color_scheme = {
		-- base16-tomorrow-night with tweaked base01 and base02
		-- mainly to make vim-illuminate look nice in visual mode
		-- until https://github.com/RRethy/vim-illuminate/issues/81 gets done
		base00 = '#1d1f21', base01 = '#2e3136', base02 = '#41464D', base03 = '#969896',
		base04 = '#b4b7b4', base05 = '#c5c8c6', base06 = '#e0e0e0', base07 = '#ffffff',
		base08 = '#cc6666', base09 = '#de935f', base0A = '#f0c674', base0B = '#b5bd68',
		base0C = '#8abeb7', base0D = '#81a2be', base0E = '#b294bb', base0F = '#a3685a'
	}
	require('base16-colorscheme').setup(color_scheme)
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
	vim.cmd('highlight IndentBlanklineChar guifg=' .. color_scheme.base02 .. ' gui=nocombine')

	use 'tpope/vim-sleuth'

	use 'ethanholz/nvim-lastplace'

	use 'leafOfTree/vim-svelte-plugin'

	use {
		'neoclide/coc.nvim',
		branch = 'release'
	}
	-- https://github.com/neoclide/coc.nvim/wiki/Using-coc-extensions#install-extensions
	vim.g.coc_global_extensions = {'coc-json', 'coc-css', 'coc-tsserver', 'coc-html', 'coc-svg', 'coc-yaml', 'coc-go', 'coc-rust-analyzer'}
	-- https://github.com/neoclide/coc.nvim#example-vim-configuration
	vim.opt.updatetime = 300
	vim.opt.cmdheight = 2
	vim.opt.shortmess:append('c')
	vim.keymap.set(
		'n',
		'<Leader>rn',
		'<Plug>(coc-rename)',
		{  }
	)
	vim.keymap.set(
		'i',
		'<CR>',
		'coc#pum#visible() ? coc#pum#confirm() : "<CR>"',
		{ expr = true }
	)
	vim.cmd('autocmd BufWritePre *.go :silent call CocAction(\'runCommand\', \'editor.action.organizeImport\')')

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

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if packer_bootstrap then
		require('packer').sync()
	end
end)
