set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

Plugin 'Valloric/YouCompleteMe'
Plugin 'rust-lang/rust.vim'
let g:rust_recommended_style = 0
"Plugin 'bling/vim-airline'
"Plugin 'scrooloose/syntastic'
Plugin 'chriskempson/tomorrow-theme', {'rtp': 'vim/'}

call vundle#end()
filetype plugin indent on
