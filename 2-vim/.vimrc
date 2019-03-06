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
" Git
Plugin 'tpope/vim-fugitive'
" Fast file navigation
Plugin 'git://git.wincent.com/command-t.git'
" Better status line
Plugin 'vim-airline/vim-airline'
" Filesystem tree
Plugin 'scrooloose/nerdtree'
" Git support on filesystem tree
Plugin 'Xuyuanp/nerdtree-git-plugin'

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

" Color Scheme
colo monokai

" Font settings
set gfn=Anonymous\ Pro\ 16

" YCM Settings
" Haskell
let g:ycm_semantic_triggers = {'haskell' : ['.']}
let g:ycm_autoclose_preview_window_after_insertion = 1

" NerdTree Settings
let g:NERDTreeWinSize=40
let mapleader = ","
map <leader>nn :NERDTreeToggle<cr>
map <leader>nb :NERDTreeFromBookmark 
map <leader>nf :NERDTreeFind<cr>

