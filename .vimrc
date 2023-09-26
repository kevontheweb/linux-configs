"   _   _ ________  _________  _____
"  | | | |_   _|  \/  || ___ \/  __ \
"  | | | | | | | .  . || |_/ /| /  \/
"  | | | | | | | |\/| ||    / | |
"  \ \_/ /_| |_| |  | || |\ \ | \__/\
" (_)___/ \___/\_|  |_/\_| \_| \____/


let mapleader = " "

" basic stuff
set nocompatible
filetype plugin on
set encoding=utf-8
scriptencoding utf-8

" colorschemes
syntax enable
set termguicolors
colorscheme darkblue
set background=dark " or light if you prefer the light version

" render whitespace
set listchars=eol:¬,tab:>-,trail:·,extends:»,precedes:»,nbsp:·
set list
autocmd filetype markdown set listchars=

" use system clipboard
set clipboard=unnamed
set clipboard+=unnamedplus

" enable mouse
set mouse=a

" enable line numbering
set number

" don't wrap text
set nowrap

" tree file viewer
let g:netrw_liststyle=3
let g:netrw_banner=0
noremap <leader>e :Vexplore<CR>

" make sure filetype is detected
autocmd BufRead,BufNewFile *.tex set filetype=tex
autocmd BufRead,BufNewFile *.bib set filetype=tex
autocmd BufRead,BufNewFile *.md  set filetype=markdown
autocmd BufRead,BufNewFile *.txt set filetype=markdown
autocmd BufRead,BufNewFile *.roff set filetype=groff
autocmd BufRead,BufNewFile *.troff set filetype=groff
autocmd BufRead,BufNewFile *.groff set filetype=groff
autocmd BufRead,BufNewFile *.tmac set filetype=groff
autocmd BufRead,BufNewFile *.ms set filetype=groff
autocmd BufRead,BufNewFile *.s set filetype=asm68k
autocmd BufRead,BufNewFile *.asm set filetype=asm68k
autocmd BufRead,BufNewFile *.tal set filetype=asm
autocmd BufRead,BufNewFile *.gp set filetype=gnuplot
autocmd BufRead,BufNewFile *.gnuplot set filetype=gnuplot
autocmd BufRead,BufNewFile *.spice set filetype=spice
autocmd BufRead,BufNewFile *.spice set filetype=spice

" spellchecking for text documents
autocmd filetype markdown,tex,latex,groff set spell
hi clear SpellBad
hi SpellBad cterm=underline,bold

" remove trailing whitespace on save
autocmd BufWritePre * %s/\s\+$//e

" open file tree
nnoremap <leader>e :vsplitC<cr>

" tabs and spaces
set tabstop=4
set shiftwidth=4
set expandtab
set smarttab
set smartindent

" ui
set showcmd
filetype indent on

" omnicomplete
set omnifunc=syntaxcomplete#Complete
set complete+=k
set completeopt=menuone,preview,longest

" highlight matching parentheses
set showmatch
set hlsearch

" Autocomplete vim commands
set wildmode=longest,list,full
set wildmenu

"ctrl + backspace in insert mode
inoremap <c-<backspace>> <Esc>vbda
