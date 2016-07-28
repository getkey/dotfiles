set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

Plugin 'Valloric/YouCompleteMe'
let g:ycm_autoclose_preview_window_after_insertion = 1
if isdirectory('/usr/src/rust')
	let g:ycm_rust_src_path = '/usr/src/rust'
endif
Plugin 'sheerun/vim-polyglot'
let g:rust_recommended_style = 0
Plugin 'Raimondi/delimitMate'
Plugin 'bolasblack/csslint.vim'
Plugin 'Valloric/MatchTagAlways'
Plugin 'airblade/vim-gitgutter'
set updatetime=250
Plugin 'tpope/vim-vinegar'
Plugin 'chriskempson/tomorrow-theme', {'rtp': 'vim/'}

call vundle#end()
filetype plugin indent on
