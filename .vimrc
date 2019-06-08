" Michele Angrisano's Vim configuration file. 2019

" Enable the indent
filetype indent plugin on

" Enable the syntax
syntax on 

" Enable the package management for the plugins
execute pathogen#infect()

" Remove trailing spaces on save
autocmd BufWritePre * :%s/\s\+$//e

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
set backup
set number
set ignorecase
set smartcase
set hlsearch
set cursorline
set autoindent
set ruler
set relativenumber
set noswapfile
set mouse=a
set tabstop=4
set textwidth=79
set shiftwidth=4
set encoding=utf-8
set background=dark
set backupdir=~/.vim/.backup
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:airline_theme='minimalist'

" Set the colorscheme
colorscheme hashpunk-sw-sweet

" Open NerdTree
map <C-n> :NERDTreeToggle<CR>

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

" Set the colorcolumn to see a limit when coding in Python
highlight ColorColumn ctermbg=198
call matchadd('ColorColumn', '\%79v', 100)
