" Michele Angrisano's Vim configuration file. 2025
vnoremap <A-k> :m '<-2<CR>gv=gv


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
set termguicolors


" Setup of vim
set expandtab
set number
set noshowmode
set wildmenu
set ignorecase
set smartcase
set hlsearch
set noerrorbells
set visualbell
set ffs=unix
set cursorline
set autoindent
set ruler
set relativenumber
set noswapfile
set nobackup
set nowritebackup
set nowrap
set display+=lastline
set mouse=a
set tabstop=4
set updatetime=500
set softtabstop=4
set shiftwidth=4
set encoding=utf-8
set backspace=2
set laststatus=2
set statusline=
set statusline +=%1*\ %n\ %*            "buffer number
set statusline +=%5*%{&ff}%*            "file format
set statusline +=%#StatuslinePastelRed#%y%*
set statusline +=%4*\ %#StatuslinePastelBlue#%<%F%*
set statusline +=%2*%m%*                "modified flag
set statusline +=%1*%=%5l%*             "current line
set statusline +=%2*/%L%*               "total lines
set statusline +=%1*%4v\ %*             "virtual column number
set statusline +=%2*0x%04B\ %*          "character under cursor

" Wintabs remap
"
map <C-H> <Plug>(wintabs_previous)
map <C-L> <Plug>(wintabs_next)
map <C-T>c <Plug>(wintabs_close)
map <C-T>u <Plug>(wintabs_undo)
map <C-T>o <Plug>(wintabs_only)
map <C-W>c <Plug>(wintabs_close_window)
map <C-W>o <Plug>(wintabs_only_window)
command! Tabc WintabsCloseVimtab
command! Tabo WintabsOnlyVimtab

" Syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_wq = 0

" Change leader for NerdCommenter
let mapleader = ","

" Jedi-Vim
let g:jedi#show_call_signatures = "1"

" NerdCommenter
let g:NERDToggleCheckAllLines = 1
let g:NERDCommentEmptyLines = 1
let g:NERDDefaultAlign = 'left'
let g:NERDCompactSexyComs = 1
let g:NERDCreateDefaultMappings = 1
let g:NERDAltDelims_java = 1

" Set the colorscheme
" packadd! dracula
colorscheme desert

" Open NerdTree
" map <C-n> :NERDTreeToggle<CR>
nnoremap <C-e> :NERDTreeToggle<CR>

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

" CtrlP
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'

" YCM Settings
let g:ycm_autoclose_preview_window_after_completion = 1

" Jump to the last position when reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

nnoremap <C-Left> :tabprevious<CR>
nnoremap <C-Right> :tabnext<CR>
nnoremap <C-j> :tabprevious<CR>
noremap <C-k> :tabnext<CR>

au FileType mail let b:delimitMate_autoclose = 0

nnoremap J :m .+1<CR>==
nnoremap K :m .-2<CR>==
vnoremap K :m '<-2<CR>gv=gv
vnoremap J :m '>+1<CR>gv=gv
set rtp+=/opt/homebrew/opt/fzf

autocmd VimEnter * highlight NonText ctermfg=NONE guifg=NONE
autocmd VimEnter * highlight EndOfBuffer ctermfg=NONE guifg=NONE

" Definisce un gruppo di evidenziazione con sfondo rosso
highlight ExtraWhitespace guibg=#ff5f5f ctermbg=red

" Match per trailing whitespace (uno o più spazi alla fine della riga)
match ExtraWhitespace /\s\+$/

highlight Visual guibg=#5f5f5f ctermbg=red
highlight StatuslineRed ctermfg=red guifg=red ctermbg=NONE guibg=NONE
highlight StatuslinePastelRed guifg=#FFB3B3 guibg=NONE ctermfg=LightRed ctermbg=NONE
highlight StatuslinePastelBlue guifg=#D0E4FF ctermfg=153 ctermbg=NONE guibg=NONE
highlight StatuslinePastelOrange guifg=#FFB580 ctermfg=215 ctermbg=NONE guibg=NONE


