call plug#begin('~/.local/share/nvim/plugged')

" Colors
Plug 'chriskempson/base16-vim'
Plug 'sheerun/vim-polyglot'

Plug 'Raimondi/delimitMate'
Plug 'tpope/vim-commentary'
Plug 'airblade/vim-gitgutter'

" navigation
Plug 'tpope/vim-vinegar'
let $FZF_DEFAULT_COMMAND = 'rg --hidden -g ''!.git/'' --files'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
nmap <C-P> :FZF<CR>
nnoremap <silent> <Leader>rg :Rg <C-R><C-W><CR>

" linting & autocompletion
Plug 'dense-analysis/ale'
let g:ale_fixers = {
\	'*': ['remove_trailing_lines', 'trim_whitespace'],
\	'javascript': ['eslint'],
\	'typescript': ['eslint'],
\	'javascriptreact': ['eslint'],
\	'typescriptreact': ['eslint'],
\	'go': ['gofmt'],
\	'rust': ['rustfmt'],
\}
let g:ale_fix_on_save = 1
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
" https://github.com/neoclide/coc.nvim/wiki/Using-coc-extensions#install-extensions
let g:coc_global_extensions = ['coc-json', 'coc-css', 'coc-tsserver', 'coc-html', 'coc-svg', 'coc-yaml', 'coc-go', 'coc-rust-analyzer']
" https://github.com/neoclide/coc.nvim#example-vim-configuration
set updatetime=300
set cmdheight=2
set shortmess+=c

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
	if (index(['vim','help'], &filetype) >= 0)
		execute 'h '.expand('<cword>')
	elseif (coc#rpc#ready())
		call CocActionAsync('doHover')
	else
		execute '!' . &keywordprg . " " . expand('<cword>')
	endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" indentation
set tabstop=4 "hard tabs are 4 spaces wide
set shiftwidth=4 "for > command
Plug 'tpope/sleuth'

call plug#end()

colorscheme base16-tomorrow-night

set number
set noswapfile

" auto reload
set autoread
autocmd FocusGained * :checktime

" clipboard
set clipboard=unnamedplus " use the system clipboard (a clipboard tool needs to be installed, check :help clipboard-tool)
set mouse=ar " all + middle click copy/paste

" clear search highligh
nnoremap <silent> <C-l> :nohl<CR><C-l>

autocmd FileType markdown,text,tex setlocal spell
autocmd BufNewFile,BufRead *.svelte set syntax=html
autocmd BufNewFile,BufRead .envrc set filetype=sh " it's executed in a bash sub-shell
autocmd FileType gitcommit setlocal textwidth=0 " don't restrict line width to 80 characters

" jumps to the last known position in a file after opening it (see :help last-position-jump)
autocmd BufReadPost *
\	if line("'\"") > 1 && line("'\"") <= line("$") && &ft !~# 'commit'
\	|	exe "normal! g`\""
\	| endif

" disable safe write that occasionally breaks watchers
" see https://github.com/rollup/rollup/issues/1666#issuecomment-547613081
set backupcopy=yes

set spelllang+=fr
