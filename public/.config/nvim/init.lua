vim.opt.number = true

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

vim.opt.swapfile = false
vim.opt.backupcopy = 'yes' -- disable safe write that occasionally breaks watchers, see https://github.com/rollup/rollup/issues/1666#issuecomment-547613081

vim.opt.autoread = true
vim.api.nvim_create_autocmd('FocusGained', {
	callback = function()
		vim.cmd('checktime')
	end,
})

vim.opt.clipboard = 'unnamedplus' -- use the system clipboard (a clipboard tool needs to be installed, check :help clipboard-tool)
vim.opt.mouse = 'ar' -- all + middle click copy/paste

-- clear search highlight
vim.keymap.set(
	'n',
	'<silent><C-l>',
	':nohlsearch<CR><C-l>',
	{ noremap = true }
)

vim.opt.spelllang:append('fr')
vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
	pattern = '.envrc',
	callback = function()
		vim.bo.filetype = 'sh'
	end,
})

vim.api.nvim_create_autocmd('FileType', {
	pattern = { 'markdown', 'text', 'tex' },
	callback = function()
		vim.opt_local.spell = true
	end,
})

vim.api.nvim_create_autocmd('FileType', {
	pattern = 'gitcommit',
	callback = function()
		vim.opt_local.textwidth = 0
	end,
})

require('plugins')
