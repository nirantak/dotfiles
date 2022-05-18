set term=screen-256color
syntax on

" Vundle begins here; turn off filetype temporarily
" set the runtime path to include Vundle and initialize
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" plugins
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'flazz/vim-colorschemes'  " https://github.com/flazz/vim-colorschemes/tree/master/colors

Plugin 'preservim/nerdtree'      " File tree explorer
Plugin 'scrooloose/syntastic'    " Syntax checker
Plugin 'tpope/vim-surround'      " Bracket matching
Plugin 'junegunn/fzf'            " Fuzzy finder
Plugin 'junegunn/fzf.vim'        " Fuzzy finder configs
Plugin 'preservim/nerdcommenter' " Better Comments
Plugin 'tpope/vim-repeat'        " Repeat plugin map commands
Plugin 'raimondi/delimitmate'    " Autoclose symbols
Plugin 'tpope/vim-markdown'      " Markdown support for old vim versions
Plugin 'bronson/vim-trailing-whitespace' " Highlight trailing whitespace

call vundle#end()

set autoindent
set bg=dark
set backspace=indent,eol,start
set cursorline
set expandtab
set ignorecase
set incsearch
set hlsearch
set laststatus=2
set linebreak
set nobackup
set noerrorbells
set nolist
set noswapfile
set novb
set nowrap
set number
set relativenumber
set ruler
set scrolloff=8
set showmatch
set shiftwidth=4
set shortmess=I
set showcmd
set showmode
set sidescroll=1
set sidescrolloff=7
set smartcase
set softtabstop=4
set undolevels=1000
set colorcolumn=80

filetype plugin indent on
highlight ColorColumn ctermbg=black
let python_highlight_all=1

"ColorScheme - PaperColor mopkai moriarty
colorscheme PaperColor

"Airline - supernova onedark
let g:airline_theme='supernova'
let g:airline_powerline_fonts=1

"NERDTree
map <C-n> :NERDTreeToggle<CR>

"FZF
nnoremap <silent> <C-f> :Files<CR>

" Ctrl + c to copy
:vmap <C-C> "+y

"nerd-commenter settings
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims=1
" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs=1
" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign='left'
" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines=1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace=1

nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
set pastetoggle=<F3>

" Remove all trailing whitespace by pressing F4
nnoremap <F4> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>

" Jump to last known cursor position
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
endif
