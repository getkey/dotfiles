"Install Vundle with git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
"Then run :PluginInstall

"begin Vundle
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

Plugin 'Valloric/YouCompleteMe'
"Plugin 'bling/vim-airline'
"Plugin 'scrooloose/syntastic'
Plugin 'chriskempson/tomorrow-theme', {'rtp': 'vim/'}

call vundle#end()
filetype plugin indent on
"end Vundle

set t_Co=256

set number
syntax on
set hlsearch "highlight search

colorscheme Tomorrow-Night
hi Normal ctermbg=NONE"Override theme's background to terminal's default

highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen "show trailing whitespace
match ExtraWhitespace /\s\+\%#\@<!$/ "except when typing at the end of a line

if has('mouse')
	if &term =~# "^screen"
		set mouse=a "all
	else
		set mouse=ar "all + middle click copy/paste
	endif
endif

set shiftwidth=3"for > command
set tabstop=3"hard tabs of length 3

au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif "remember position in file
set noswapfile
