" Michele Angrisano's Vim configuration file. 2021

" Enable the indent
filetype indent plugin on

" Enable the syntax
syntax on

" Enable the package management for the plugins
execute pathogen#infect()

" Remove trailing spaces on save
autocmd BufWritePre * :%s/\s\+$//e

" Path for browsing
set path+=**

" Set the headers of the program languagages
augroup Shebang
  autocmd BufNewFile *.py 0put =\"#!/usr/bin/env python\<nl># -*- coding: utf-8 -*-\<nl>\"|$
  autocmd BufNewFile *.sh 0put =\"#!/bin/bash\<nl>\"|$
  autocmd BufNewFile *.rb 0put =\"#!/usr/bin/env ruby\<nl># -*- coding: None -*-\<nl>\"|$
  autocmd BufNewFile *.tex 0put =\"%&plain\<nl>\"|$
  autocmd BufNewFile *.c 0put =\"#include <stdio.h>\<nl>#include <stdlib.h>\<nl>#include <string.h>\<nl>#include <unistd.h>\"|$
  autocmd BufNewFile *cpp 0put =\"#include <iostream>\<nl>\"|$
  autocmd BufNewFile *.\(cc\|hh\) 0put =\"//\<nl>// \".expand(\"<afile>:t\").\" -- \<nl>//\<nl>\"|2|start!
augroup END

" Setup of vim
set expandtab
set number
set wildmenu
set ignorecase
set smartcase
set hlsearch
set noerrorbells
set visualbell
set cursorline
set autoindent
set ruler
set relativenumber
set noswapfile
set nobackup
set nowritebackup
set nowrap
set display+=lastline
set guifont=Iosevka
set mouse=a
set tabstop=4
set updatetime=500
set textwidth=79
set softtabstop=4
set shiftwidth=4
set encoding=utf-8
set background=dark
set backspace=2

" Statusline
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:airline_theme='minimalist'

" Syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_wq = 0

" Change leader for NerdCommenter
let mapleader = ","

" NerdCommenter
let g:NERDToggleCheckAllLines = 1
let g:NERDCommentEmptyLines = 1
let g:NERDDefaultAlign = 'left'
let g:NERDCompactSexyComs = 1
let g:NERDCreateDefaultMappings = 1
let g:NERDAltDelims_java = 1

" Set the colorscheme
" Solarized theme: https://github.com/altercation/vim-colors-solarized
colorscheme solarized

" Open NerdTree
map <C-n> :NERDTreeToggle<CR>

" Open TagBarToggle
map <C-t> :TagbarToggle<CR>

" Remap the Escape with jj
inoremap jj <Esc>

" Set the cursor shape:
" [0] - reset the cursor after closing vim
" [1] - block in Normal Mode
" [5] - vertical bar in Insert Mode
let &t_ti.="\e[1 q"
let &t_SI.="\e[5 q"
let &t_EI.="\e[1 q"
let &t_te.="\e[0 q"

" YCM Settings
let g:ycm_autoclose_preview_window_after_completion = 1

" Set the colorcolumn to see a limit when coding in Python
highlight ColorColumn ctermbg=198
call matchadd('ColorColumn', '\%79v', 100)

" Jump to the last position when reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

nnoremap <C-Left> :tabprevious<CR>
nnoremap <C-Right> :tabnext<CR>
nnoremap <C-j> :tabprevious<CR>
noremap <C-k> :tabnext<CR>

au FileType mail let b:delimitMate_autoclose = 0

" Tabnine Settings
set rtp+=~/.vim/bundle/tabnine-vim

" CtrlP
set runtimepath^=~/.vim/bundle/ctrlp.vim
let g:ctrlp_working_path_mode = 'ra'
