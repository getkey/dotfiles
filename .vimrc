source ~/.vim/vundle-loader.vim

set t_Co=256

set number
syntax on
set hlsearch "highlight search

colorscheme Tomorrow-Night
hi Normal ctermbg=NONE"Override theme's background to terminal's default

highlight ExtraWhitespace ctermbg=darkred guibg=darkred "show trailing whitespace
autocmd Syntax * syn match ExtraWhitespace /\s\+\%#\@<!$/ "except when typing at the end of a line

highlight SpaceIndent ctermbg=darkgrey guibg=darkgrey "two or more consecutive spaces
autocmd Syntax * syn match SpaceIndent / \{2,\}/

if has('mouse')
	if &term =~# "^screen"
		set mouse=a "all
	else
		set mouse=ar "all + middle click copy/paste
	endif
endif

set shiftwidth=4 "for > command
set tabstop=4 "hard tabs are 4 spaces wide
set noexpandtab"always insert tabs with the tab key

au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif "remember position in file
set noswapfile
