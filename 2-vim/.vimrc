set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
" Color Scheme
Plugin 'sickill/vim-monokai'
" AutoComplete
Plugin 'Valloric/YouCompleteMe'
" AutoCompleteGenerator
Plugin 'rdnetto/YCM-Generator'
" Color coded
Plugin 'jeaye/color_coded'
" Git
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'
" Fast file navigation
Plugin 'git://git.wincent.com/command-t.git'
" Better status line
Plugin 'vim-airline/vim-airline'
" Filesystem tree
Plugin 'scrooloose/nerdtree'
" Git support on filesystem tree
Plugin 'Xuyuanp/nerdtree-git-plugin'
" Better icons
Plugin 'ryanoasis/vim-devicons'

" Language Plugins
" ReasonML
Plugin 'reasonml-editor/vim-reason-plus'
" Haskell
Plugin 'eagletmt/neco-ghc'
Plugin 'eagletmt/ghcmod-vim'
Plugin 'neovimhaskell/haskell-vim'


" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required


" My settings
syntax on
set tabstop=4
set softtabstop=4
set shiftwidth=4
set nu
set expandtab
set ruler
set autoread
set cursorline
set hidden

colo monokai

" Font settings
set encoding=UTF-8
set gfn=Anonymice\ Nerd\ Font\ Complete\ Mono\ 16

let g:airline_powerline_fonts = 1

" airline Settings
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#switch_buffers_and_tabs = 1
let g:airline#extensions#tabline#keep_orig_tabline = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
nnoremap <C-[>   :bp<cr>
nnoremap <C-]>   :bn<cr>

function! BufferDelete()
    if len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) > 1
        execute "bp|bd#"
    else
        execute "enew|bd#"
    endif
endfunction
nnoremap <C-_> :call BufferDelete()<CR>

" YCM Settings
" Haskell
let g:ycm_semantic_triggers = {'haskell' : ['.']}
let g:ycm_autoclose_preview_window_after_insertion = 1

" NerdTree Settings
let g:NERDTreeWinSize=40
let g:NERDTreeMinimalUI=1
let g:mapleader = ","
map <leader>nn :NERDTreeToggle<cr>
map <leader>nb :NERDTreeFromBookmark 
map <leader>nf :NERDTreeFind<cr>

" nf-fa-caret_[right, down]
let g:NERDTreeDirArrowExpandable = "\uf0da"
let g:NERDTreeDirArrowCollapsible = "\uf0d7"

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Use monospace font for git-plugin
" Modified: nf-oct-diff_modified
" Staged: nf-oct-diff_added
" Untracked: nf-oct-issue_opened
" Renamed: nf-oct-diff_renamed
" Unmerged: nf-oct-gist
" Deleted: nf-oct-diff_removed
" Dirty: nf-oct-pencil
" Clean: nf-oct-check
" Ignored: nf-oct-diff_ignored
" Unknown: nf-oct-question
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "\uf459",
    \ "Staged"    : "\uf457",
    \ "Untracked" : "\uf41b",
    \ "Renamed"   : "\uf45a",
    \ "Unmerged"  : "\uf40c",
    \ "Deleted"   : "\uf458",
    \ "Dirty"     : "\uf448",
    \ "Clean"     : "\uf42e",
    \ 'Ignored'   : '\uf474',
    \ "Unknown"   : "\uf420"
    \ }

