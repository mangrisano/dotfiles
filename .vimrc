" Michele Angrisano's Vim configuration file.

" Enable the syntax
syntax on 

" Enable the indent
filetype indent plugin on

" Enable the pathogen for plugins
execute pathogen#infect()

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
set tabstop=4
set shiftwidth=4
set expandtab       
set number
set hlsearch
set noautoindent
set textwidth=79
set ruler
set rnu 
set mouse=a
set encoding=utf-8
set background=light
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:airline_theme='minimalist'

" Set the colorscheme
colorschem hashpunk-sw-sweet

" Open NerdTree
map <C-n> :NERDTreeToggle<CR>

" Remap the Escape with jj
inoremap jj <Esc>
