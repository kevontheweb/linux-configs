"   _   _ ________  _________  _____
"  | | | |_   _|  \/  || ___ \/  __ \
"  | | | | | | | .  . || |_/ /| /  \/
"  | | | | | | | |\/| ||    / | |
"  \ \_/ /_| |_| |  | || |\ \ | \__/\
" (_)___/ \___/\_|  |_/\_| \_| \____/


let mapleader = ";"
let $VIM="/home/cheese/.vim"

" basic stuff
set nocompatible
filetype plugin on
set encoding=utf-8
scriptencoding utf-8

" PLUGINS
" auto install vimplug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'junegunn/goyo.vim'
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/limelight.vim'
" Plug 'sheerun/vim-polyglot'
Plug 'karolbelina/uxntal.vim'
Plug 'ackyshake/VimCompletesMe'
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'rakr/vim-two-firewatch'
Plug 'jeffkreeftmeijer/vim-dim'
call plug#end()

" colorschemes
syntax enable
"set termguicolors
set background=dark " or light if you prefer the light version
let g:tokyonight_style = 'night' " available: night, storm
let g:tokyonight_enable_italic = 1
" colorscheme tokyonight
" let g:two_firewatch_italics=1
" colorscheme two-firewatch
colorscheme dim

" fix non transparent background
" highlight Normal ctermbg=NONE

" fix weird line number coloring
" highlight clear SignColumn
" highlight clear LineNr

" render whitespace
set listchars=eol:¬,tab:>-,trail:·,extends:»,precedes:»,nbsp:·
set list
autocmd filetype markdown set listchars=

" use system clipboard
set clipboard=unnamed
set clipboard+=unnamedplus

" set working dir to current file
set autochdir

" enable mouse
set mouse=a

" enable line numbering
set number relativenumber

" don't wrap text
set nowrap

" give path to python for plugins to use
let g:python_host_prog='/usr/bin/python'
let g:python3_host_prog='/usr/bin/python3'

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

" spellchecking for text documents
autocmd filetype markdown,tex,latex,groff set spell
hi clear SpellBad
hi SpellBad cterm=underline,bold

" remove trailing whitespace on save
autocmd BufWritePre * %s/\s\+$//e

" open horizontal pane to edit .vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<cr>

" tabs and spaces
set tabstop=4
set shiftwidth=4
set expandtab

" ui
set showcmd
filetype indent on

" omnicomplete
set omnifunc=syntaxcomplete#Complete
set complete+=k
set completeopt=menuone,preview,longest

" highlight matching parentheses
set showmatch

" REMAPS
" autoclosing brackets
" inoremap " ""<left>
" inoremap ' ''<left>
" inoremap ( ()<left>
" inoremap [ []<left>
" inoremap { {}<left>
" inoremap {<CR> {<CR>}<ESC>O
" inoremap {;<CR> {<CR>};<ESC>O

" markdown auto close formatting
" autocmd filetype markdown inoremap * **<left>
" autocmd filetype markdown inoremap _ __<left>

" Autocomplete
set wildmode=longest,list,full
set wildmenu

" Navigating with guides
inoremap <leader><leader> <Esc>/<++><Enter>"_c4l
vnoremap <leader><leader> <Esc>/<++><Enter>"_c4l
map <leader><leader> <Esc>/<++><Enter>"_c4l

" swithing panes
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

"ctrl + backspace in insert mode
inoremap <c-<backspace>> <Esc>vbda
" --- Plugin Configs ----

" toggle goyo
noremap <leader>g :Goyo<CR>
let g:limelight_conceal_ctermfg = 'DarkGray'
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

" easy align
" Start interactive EasyAlign in visual mode
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object
nmap ga <Plug>(EasyAlign)

" ---- COMPILE SCRIPTS ----

" md to html with tufte css for notes
" autocmd filetype markdown noremap <leader>c :w <bar> :!pandoc % --mathjax --toc --css  "https://cdnjs.cloudflare.com/ajax/libs/tufte-css/1.4/tufte.min.css" -s -o %:r.html<CR>
autocmd filetype markdown noremap <leader>c :w <bar> :!pandoc % --katex --highlight-style zenburn --toc -s -o %:r.html<CR>


" groff
" compile on save
autocmd InsertLeave *.ms silent! execute "!refer %  | groff -ms -e -p -t -Tps > %:r.ps; ps2pdf %:r.ps %:r.pdf" | redraw!

" LaTeX
autocmd filetype tex,latex noremap <leader>c :w <bar> :!latexmk % <CR>
autocmd filetype tex,latex noremap <leader>p :w <bar> :!latexmk % -pvc <CR> <bar> :!zathura %:r.pdf<CR>

" Python
autocmd filetype python noremap <leader>r <ESC>:w<CR> :!python3 % <CR>

" Markdown
autocmd InsertLeave *.md silent! execute ":w"

" ---- sourced configs ----

" SNIPPETS
source $VIM/macros.vim

" COC setup
" source $VIM/coc.vim

" STATUSLINE
source $VIM/statusline.vim

" EMOJIS
dig rb 128997 " 🟥
dig bb 128998 " 🟦
dig ob 128999 " 🟧
dig yb 129000 " 🟨
dig gb 129001 " 🟩
dig pb 129002 " 🟪
dig cf 9749   " ☕
dig lt 9889   " ⚡
dig st 10024  " ✨
dig ck 9989   " ✅
dig cs 10062  " ❎

dig <3 129293 " 🤍
dig :) 128578 " 🙂
dig :( 128577 " 🙁
dig ;) 128521 " 😉
dig :P 128523 " 😋
dig xD 128514 " 😂
dig B) 128526 " 😎
dig :/ 128528 " 😐
dig (: 128579 " 🙃
dig 3) 128522 " 😊
dig 3( 128532 " 😔
dig :L 128530 " 😒
dig ;P 128540 " 😜
dig >: 128545 " 😡
dig :; 128546 " 😢
dig :< 128548 " 😤
dig :I 128556 " 😬
dig := 128557 " 😭
dig :o 128558 " 😮
dig :O 128561 " 😱
dig 8/ 128563 " 😳
dig z: 128564 " 😴
dig xo 128565 " 😵
dig </ 128580 " 🙄
dig hn 128588 " 🙌
dig tx 128591 " 🙏
dig ok 128076 " 👌
dig mm 129292 " 🤌

