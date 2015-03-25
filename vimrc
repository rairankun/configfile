"----------------------------------------------------
" setting
"----------------------------------------------------
set nocompatible
set showcmd
set showmode
set cursorline
set nohidden
set autoread
set clipboard=unnamed

"----------------------------------------------------
" color scheme
"----------------------------------------------------
if &t_Co > 1
	syntax enable
endif
let g:molokai_original = 1
set t_Co=256
colorscheme molokai				"apollon
"colorscheme zenburn			"local

"----------------------------------------------------
" indent
"----------------------------------------------------
set tabstop=4
set autoindent
set expandtab
set shiftwidth=4

"----------------------------------------------------
" disp setting
"----------------------------------------------------
set number
set ruler
set showmatch
map n nzz

"---------------------------------------------------
" statusline
"---------------------------------------------------
set laststatus=2
set statusline=
set statusline+=%-3.3n\                             " buffer number
set statusline+=%f\                                 " file name
set statusline+=%h%m%r%w                            " flags
set statusline+=\[%{strlen(&ft)?&ft:'none'},        " filetype
set statusline+=%{&encoding},                       " encoding
set statusline+=%{&fileformat}]\                    " file format
set statusline+=%=                                  " right align
set statusline+=0x%B(%b)\                           " current char hexadecimal(decimal)
set statusline+=%-10.(%l,%c%V%)\ %<%P               " offset

" statusline colors
if version >= 700
	" default statusline highlight (colors)
	hi StatusLine   ctermbg=3 ctermfg=0 gui=bold
	" default non-currenct statusline highlight
	hi StatusLineNC ctermbg=3 ctermfg=0 gui=bold
	" statusline highlight when in INSERT mode
	au InsertEnter * hi StatusLine ctermbg=6 ctermfg=0 gui=bold
	" leaving INSERT mode reset to default
	au InsertLeave * hi StatusLine ctermbg=3 ctermfg=0 gui=bold
endif

"--------------------------------------------------
" search
"--------------------------------------------------
vnoremap * "zy:let @/ = @z<CR>n
set hlsearch
set incsearch
nnoremap <Esc><Esc> :<C-u>nohlsearch<Return>
highlight WhitespaceEOL ctermbg=red guibg=red
match WhitespaceEOL /\s\+$/

"----------------------------------------------------
" GNU GLOBAL(gtags)
"----------------------------------------------------
nmap <C-q> <C-w><C-w><C-w>q
nmap <C-g> :Gtags -g
nmap <C-l> :Gtags -f %<CR>
nmap <C-j> :Gtags <C-r><C-w><CR>
nmap <C-k> :Gtags -r <C-r><C-w><CR>
nmap <C-n> :cn<CR>
nmap <C-p> :cp<CR>

"---------------------------------------------------
" window
"---------------------------------------------------
nnoremap <silent> <C-x>1 :only<CR>
nnoremap <silent> <C-x>2 :sp<CR>
nnoremap <silent> <C-x>3 :vsp<CR>

"---------------------------------------------------
" Displace
"---------------------------------------------------
nnoremap <expr> <C-r> ':%s ;\<' . expand('<cword>') . '\>;'
vnoremap <expr> <C-r> ':s ;\<' . expand('<cword>') . '\>;'

