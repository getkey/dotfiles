set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

Plugin 'Valloric/YouCompleteMe'
Plugin 'rdnetto/YCM-Generator' " generates YCM config files for C-family languages
let g:ycm_autoclose_preview_window_after_insertion = 1
if isdirectory('/usr/src/rust')
	let g:ycm_rust_src_path = '/usr/src/rust'
endif

Plugin 'sheerun/vim-polyglot'
let g:rust_recommended_style = 0

Plugin 'Raimondi/delimitMate'

Plugin 'bolasblack/csslint.vim'

Plugin 'chrisbra/Colorizer'
let g:colorizer_auto_filetype='css,html,svg'

Plugin 'Valloric/MatchTagAlways'

Plugin 'airblade/vim-gitgutter'
set updatetime=250

Plugin 'tpope/vim-vinegar'

Plugin 'tomazy/tomorrow-theme', {'rtp': 'vim/'} " chriskempson/tomorrow-theme fork that supports pangloss/vim-javascript
Plugin 'chriskempson/base16-vim'

Plugin 'SirVer/ultisnips' " snippet engine
let g:UltiSnipsExpandTrigger = "<nop>"
let g:ulti_expand_or_jump_res = 0
function ExpandSnippetOrCarriageReturn()
    let snippet = UltiSnips#ExpandSnippetOrJump()
    if g:ulti_expand_or_jump_res > 0
        return snippet
    else
        return "\<CR>"
    endif
endfunction
inoremap <expr> <CR> pumvisible() ? "<C-R>=ExpandSnippetOrCarriageReturn()<CR>" : "\<CR>"
Plugin 'honza/vim-snippets' " snippets themselves

call vundle#end()
filetype plugin indent on
