" Copyright 2020 - Samuel Oechsler
" Personal default settings for VIM

"Plugin manager {{{
set nocompatible
filetype off

execute pathogen#infect()
call vundle#begin()

"Vundle managed by itself
Plugin 'VundleVim/Vundle.vim'

"General Plugins
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'tacahiroy/ctrlp-funky'
Plugin 'Valloric/YouCompleteMe'
Plugin 'Raimondi/delimitMate'
Plugin 'tpope/vim-fugitive'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'mrmargolis/dogmatic.vim'
Plugin 'mattn/emmet-vim'
Plugin 'easymotion/vim-easymotion'
Plugin 'sudo.vim'
Plugin 'chrisbra/colorizer'
Plugin '907th/vim-auto-save'

call vundle#end()
filetype plugin indent on
" }}}

"Colors {{{
colorscheme molokai "Monokai for VIM!

"Mark only line that overrun the colorcolumn
call matchadd('ColorColumn', '\%81v', 100)
" }}}

"Editor layout {{{
filetype indent on
syntax enable
set number
set relativenumber
set cursorline
set splitbelow

"Don't f***ing beep
set visualbell
set noerrorbells

"Auto save
let g:auto_save = 1

"Autocomplete for commands
set wildmenu
set showcmd

let g:colorizer_auto_color = 1
set lazyredraw
set clipboard=unnamed
" }}}

"iTerm 2 & MacVim settings {{{
set ttyfast
set mouse=a

set guifont=Fira\ Code\ Retinae:h13
"set columns=80
"set lines=24
set guioptions=
" }}}

"Tab {{{
set backspace=2
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
" }}}

 "Movement & remaps {{{
let mapleader = ","

"First none whitspace char
nnoremap 1 ^

"Line by line movement
nnoremap j gj
nnoremap k gk

"Easymotion
map <Leader> <Plug>(easymotion-prefix)

"Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

"Split hotkeys
nnoremap <C-w>h <C-w>s

"Tab hotkey
nnoremap t0 :tabfirst<CR>
nnoremap th :tabprevious<CR>
nnoremap tl :tabnext<CR>
nnoremap <C-w>t :tabnew<CR>

"Gitdiff/blame hotkey
nnoremap <C-d> :Gdiff<CR>
nnoremap <C-a> :Gblame<CR>

"Golang hotkeys
nnoremap gi :GoImport<space>
nnoremap gI :GoDrop<space>
nnoremap ga :GoImportAs<space>

"Multiple cursors hotkeys
let g:multi_cursor_select_all_word_key = '<leader><C-d>'
let g:multi_cursor_select_all_key      = '<leader>g<C-d>'
"}}}

"Folding {{{
set foldenable
set foldmethod=indent
set foldlevelstart=10
nnoremap <space> za
" }}}

"Search {{{
set hlsearch
set showmatch
set incsearch
set ignorecase
set smartcase
nnoremap <leader><space> :nohlsearch<CR>
" }}}

"HTML editing {{{
set matchpairs+=<:>
" }}}

"Powerline {{{
let g:Powerline_symbols = 'fancy'
set laststatus=2
set showtabline=1
set encoding=utf-8
set noshowmode
set t_Co=256
" }}}

"CtrlP {{{
"set runtimepath+=~/.vim/bundle/ctrlp.vim
nnoremap <c-o> :CtrlPFunky<CR>
" }}}

"Nerdtree {{{
let NERDTreeMapActivateNode = '<space>'
"let g:nerdtree_tabs_autofind = 1

map <silent> <C-b> :NERDTreeFocus<CR>
" }}}

"YouCompleteMe {{{
let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
" }}}

"Marker folding {{{
set modelines=1
" }}}

" vim:foldmethod=marker:foldlevel=0
