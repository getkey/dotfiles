call plug#begin('~/.local/share/nvim/plugged')

" Colors
Plug 'chriskempson/base16-vim'
Plug 'sheerun/vim-polyglot'

Plug 'Raimondi/delimitMate'
Plug 'tpope/vim-commentary'
Plug 'airblade/vim-gitgutter'

" navigation
Plug 'tpope/vim-vinegar'
Plug 'ctrlpvim/ctrlp.vim'
let g:ctrlp_show_hidden = 1
if executable('rg')
	let g:ctrlp_user_command = 'rg --hidden -g ''!.git/'' --files --color=never %s'
endif

" linting & autocompletion
Plug 'w0rp/ale'
Plug 'mhartington/nvim-typescript', {'do': './install.sh'}
let g:nvim_typescript#javascript_support = 1
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
let g:deoplete#enable_at_startup = 1
call plug#end()


colorscheme base16-tomorrow-night

set number
set noswapfile

" clipboard
set clipboard=unnamedplus " use the system clipboard (a clipboard tool needs to be installed, check :help clipboard-tool)
set mouse=ar " all + middle click copy/paste

" tabs
set shiftwidth=4 "for > command
set tabstop=4 "hard tabs are 4 spaces wide
set noexpandtab "always insert tabs with the tab key

autocmd BufNewFile,BufRead *.svelte set syntax=html