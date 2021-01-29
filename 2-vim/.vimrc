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
Plugin 'crusoexia/vim-monokai'
" Indentation detection
Plugin 'tpope/vim-sleuth'
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
" Manage parentheses, tags, quotes, ...
Plugin 'tpope/vim-surround'
" Search highlight
Plugin 'romainl/vim-cool'
" Comment lines
Plugin 'scrooloose/nerdcommenter'
" Tags
Plugin 'majutsushi/tagbar'
" Sessions
Plugin 'tpope/vim-obsession'
Plugin 'dhruvasagar/vim-prosession'

Plugin 'iamcco/markdown-preview.nvim'
Plugin 'gabrielelana/vim-markdown'

" Rust
Plugin 'rust-lang/rust.vim'

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
set nu
set expandtab
set ruler
set autoread
set cursorline
set hidden
set showmatch
set mat=1
set ignorecase
set smartcase
set incsearch
set scrolloff=3
set hls
set noswapfile


colo monokai

" Font settings
set encoding=UTF-8
set gfn=Anonymice\ Nerd\ Font\ Complete\ Mono\ 16

" Split manipulation
nnoremap <Up> :res +2<cr>
nnoremap <Down> :res -2<cr>
nnoremap <Left> :vertical res -2<cr>
nnoremap <Right> :vertical res +2<cr>

let g:airline_powerline_fonts = 1

" airline Settings
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#switch_buffers_and_tabs = 1
let g:airline#extensions#tabline#keep_orig_tabline = 1

execute "set <M-q>=\eq"
execute "set <M-e>=\ee"
execute "set <M-1>=\e1"
execute "set <M-2>=\e2"
execute "set <M-3>=\e3"
execute "set <M-4>=\e4"
nmap <M-q>   <Plug>AirlineSelectPrevTab
nmap <M-e>   <Plug>AirlineSelectNextTab
nmap <M-1>   <Plug>AirlineSelectTab1
nmap <M-2>   <Plug>AirlineSelectTab2
nmap <M-3>   <Plug>AirlineSelectTab3
nmap <M-4>   <Plug>AirlineSelectTab4

function! BufferDelete()
    if len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) > 1
        if len(filter(range(1, bufnr('%')), 'buflisted(v:val)')) == 1
            execute "normal \<Plug>AirlineSelectNextTab"
        else
            execute "normal \<Plug>AirlineSelectPrevTab"
        endif
        execute "bd#"
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
let g:NERDTreeWinSize = 40
let g:NERDTreeMinimalUI = 1
let NERDTreeAutoDeleteBuffer = 1
let g:mapleader = ","
map <leader>nn :NERDTreeToggle<cr>
map <leader>nb :NERDTreeFromBookmark
map <leader>nf :NERDTreeFind<cr>

map <leader>yy :<C-U>silent '<,'>:w !~/yank.sh<CR>:redraw<CR>

" nf-fa-caret_[right, down]
let g:NERDTreeDirArrowExpandable = "\uf0da"
let g:NERDTreeDirArrowCollapsible = "\uf0d7"

augroup vimrc
    autocmd!
    autocmd VimEnter * NERDTree | wincmd p
    autocmd User ProsessionPost NERDTree | wincmd p
augroup END

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
" 
let g:NERDTreeGitStatusIndicatorMapCustom = {
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

" Tags window
nmap <F8> :TagbarToggle<CR>
let g:tagbar_vertical = 15
highlight link TagbarSignature Keyword

" Markdown Preview
let g:mkdp_open_to_the_world = 1
let g:mkdp_open_ip = '0.0.0.0'
let g:mkdp_port = 2700

function! GetMKDPUrl()
    if exists('w:mkdp_url')
        return expand('%f') . '  Preview: ' . w:mkdp_url
    else
        return expand('%f')
    endif
endfunction

function! EchoUrlToStatusLine(...)
    if &filetype == 'markdown'
        let w:airline_section_c = '%{GetMKDPUrl()}'
    endif
endfunction

call airline#add_statusline_func('EchoUrlToStatusLine')
function! g:EchoUrl(url)
    :echo a:url
    let w:mkdp_url = a:url
    :AirlineRefresh
endfunction
let g:mkdp_browserfunc = 'g:EchoUrl'

let g:markdown_enable_input_abbreviations = 0
let g:markdown_enable_spell_checking = 0

let g:rustfmt_command = 'rustfmt +nightly'
let g:rustfmt_autosave = 1
