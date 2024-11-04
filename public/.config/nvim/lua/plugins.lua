local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{
		"RRethy/nvim-base16",
		config = function()
			vim.cmd.colorscheme('base16-tomorrow-night')
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require('gitsigns').setup()
		end,
	},
	{
		"ruifm/gitlinker.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require('gitlinker').setup()
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		keys = {
			{ "<C-P>", ":Telescope find_files find_command=rg,--ignore,--hidden,-g,!.git/,--files<CR>" },
			{ "<C-S-F>", ":Telescope grep_string<CR>" },
			{ "<C-F>", ":Telescope live_grep<CR>" },
			{ "gr", ":Telescope lsp_references<CR>" },
			{ "gd", ":Telescope lsp_definitions<CR>" },
		},
	},
	{
		"numToStr/Comment.nvim",
		config = function()
			require('Comment').setup()
		end,
	},
	{
		'windwp/nvim-autopairs',
		config = function()
			require('nvim-autopairs').setup{}
		end,
	},
	'tpope/vim-vinegar',
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("copilot").setup({
				suggestion = {
					auto_trigger = true,
					keymap = {
						accept = "<S-Tab>",
					},
				}
			})
		end,
	},
	'RRethy/vim-illuminate',
	'lukas-reineke/indent-blankline.nvim',
	'tpope/vim-sleuth',
	'ethanholz/nvim-lastplace',
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			local configs = require("nvim-treesitter.configs")

			configs.setup({
				ensure_installed = { "lua", "javascript", "html", "css", "json", "typescript", "go", "gomod", "gosum", "yaml" },
				sync_install = false,
				highlight = { enable = true },
				indent = { enable = true },
			})
		end
	},
	'neovim/nvim-lspconfig',

	'hrsh7th/cmp-nvim-lsp',
	'hrsh7th/cmp-path',
	'hrsh7th/nvim-cmp',

	'hrsh7th/cmp-vsnip',
	'hrsh7th/vim-vsnip',

	{
		'lukas-reineke/lsp-format.nvim',
		config = function()
			require("lsp-format").setup {}
		end,
	},
})

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
		{ name = 'path' },
	}),
})

local on_attach = function(client, bufnr)
	vim.keymap.set('n', '<Leader>cr', vim.lsp.buf.rename, bufopts)
	require("lsp-format").on_attach(client, bufnr)
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()

local lspconfig = require('lspconfig')

local servers = { 'ts_ls', 'gopls', 'eslint' }
for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup {
		on_attach = on_attach,
		capabilities = capabilities,
	}
end
