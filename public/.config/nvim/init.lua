require('plugins')

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
vim.keymap.set(
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
