vim.opt.number = true

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

vim.opt.swapfile = false
vim.opt.backupcopy = 'yes' -- disable safe write that occasionally breaks watchers, see https://github.com/rollup/rollup/issues/1666#issuecomment-547613081

vim.opt.autoread = true
vim.cmd('autocmd FocusGained * :checktime')

vim.opt.clipboard = 'unnamedplus' -- use the system clipboard (a clipboard tool needs to be installed, check :help clipboard-tool)
vim.opt.mouse = 'ar' -- all + middle click copy/paste

-- clear search highlight
vim.api.nvim_set_keymap(
	'n',
	'<silent><C-l>',
	':nohlsearch<CR><C-l>',
	{ noremap = true }
)

vim.opt.spelllang:append('fr')
vim.cmd([[
autocmd BufNewFile,BufRead .envrc set filetype=sh " it's executed in a bash sub-shell
autocmd FileType markdown,text,tex setlocal spell
autocmd FileType gitcommit setlocal textwidth=0 " don't restrict line width to 80 characters
]])

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
		requires = {
			'nvim-lua/plenary.nvim'
		},
		tag = 'release',
		config = function()
			require('gitsigns').setup()
		end
	}
	require('gitsigns').setup()

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
		'<Leader>rg',
		':Telescope grep_string<CR>',
		{}
	)

	use 'numToStr/Comment.nvim'
	require('Comment').setup()

	use 'windwp/nvim-autopairs'
	require('nvim-autopairs').setup{}

	use 'tpope/vim-vinegar'

	use 'github/copilot.vim'

	use 'RRethy/vim-illuminate'

	use 'lukas-reineke/indent-blankline.nvim'
	vim.cmd('highlight IndentBlanklineChar guifg=' .. color_scheme.base02 .. ' gui=nocombine')

	use 'tpope/vim-sleuth'

	use 'ethanholz/nvim-lastplace'

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
	vim.api.nvim_set_keymap(
		'n',
		'<Leader>rn',
		'<Plug>(coc-rename)',
		{  }
	)

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
	vim.g.ale_fix_on_save = 1

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if packer_bootstrap then
		require('packer').sync()
	end
end)
