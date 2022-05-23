" Install vim=plug if not present
if empty(glob('~/.vim/autoload/plug.vim'))
  silent execute '!curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Vim-Plug
call plug#begin()
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Plug 'joshdick/onedark.vim'
Plug 'flazz/vim-colorschemes'
Plug 'airblade/vim-gitgutter'
Plug 'preservim/nerdtree'
Plug 'preservim/tagbar'
Plug 'sheerun/vim-polyglot'
Plug 'dense-analysis/ale'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-markdown'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'bronson/vim-trailing-whitespace'
call plug#end()

set term=screen-256color
set t_Co=256
set t_ut=

set fileformat=unix
set encoding=utf-8
set fileencoding=utf-8

syntax on
filetype plugin indent on

set mouse=a
set autoindent
set bg=dark
set backspace=indent,eol,start
set cursorline
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
set shortmess=I
set showcmd
set showmode
set smartcase
set sidescroll=1
set sidescrolloff=7
set undolevels=1000
set colorcolumn=80

set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
autocmd FileType python setlocal tabstop=4 shiftwidth=4 softtabstop=4
au FileType python let b:AutoPairs = AutoPairsDefine({"f'" : "'", "r'" : "'", "b'" : "'"})

highlight ColorColumn ctermbg=black
let python_highlight_all=1

" ColorScheme - onedark PaperColor mopkai moriarty
colorscheme PaperColor

" Airline - onedark supernova
let g:airline_theme='supernova'
let g:airline_powerline_fonts=1

" move through split windows
nmap <Leader><Up> :wincmd k<CR>
nmap <Leader><Down> :wincmd j<CR>
nmap <Leader><Left> :wincmd h<CR>
nmap <Leader><Right> :wincmd l<CR>

" move through buffers
nmap <Leader>b :buffers<CR>:buffer<Space>
nmap <Leader>[ :bp!<CR>
nmap <Leader>] :bn!<CR>
nmap <Leader>x :bp<bar>bd#<CR>

" NERDTree https://github.com/preservim/nerdtree/blob/master/doc/NERDTree.txt
map <C-n> :NERDTreeToggle<CR>
map <Leader>n :NERDTreeToggle<CR>
let NERDTreeIgnore = ['^\.git$', '^\.venv$', '\.pyc$', '__pycache__', '^node_modules$']
let NERDTreeMinimalUI = 1
let NERDTreeShowHidden = 1
" Start NERDTree on load and put the cursor back in the other window.
" autocmd VimEnter * NERDTree | wincmd p
" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
" Close the tab if NERDTree is the only window remaining in it.
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" FZF
nnoremap <silent> <C-f> :Files<CR>

" ale
map <C-e> <Plug>(ale_next_wrap)
map <C-r> <Plug>(ale_previous_wrap)

" tags
map <Leader>t :TagbarToggle<CR>

" Remove all trailing whitespace by pressing F4
nnoremap <F4> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>

" Wrap toggle
setlocal nowrap
noremap <silent> <Leader>w :call ToggleWrap()<CR>
function ToggleWrap()
  if &wrap
    echo "Wrap OFF"
    setlocal nowrap
    set virtualedit=all
    silent! nunmap <buffer> <Up>
    silent! nunmap <buffer> <Down>
    silent! nunmap <buffer> <Home>
    silent! nunmap <buffer> <End>
    silent! iunmap <buffer> <Up>
    silent! iunmap <buffer> <Down>
    silent! iunmap <buffer> <Home>
    silent! iunmap <buffer> <End>
  else
    echo "Wrap ON"
    setlocal wrap linebreak nolist
    set virtualedit=
    setlocal display+=lastline
    noremap  <buffer> <silent> <Up>   gk
    noremap  <buffer> <silent> <Down> gj
    noremap  <buffer> <silent> <Home> g<Home>
    noremap  <buffer> <silent> <End>  g<End>
    inoremap <buffer> <silent> <Up>   <C-o>gk
    inoremap <buffer> <silent> <Down> <C-o>gj
    inoremap <buffer> <silent> <Home> <C-o>g<Home>
    inoremap <buffer> <silent> <End>  <C-o>g<End>
  endif
endfunction

" Jump to last known cursor position
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
endif

set pastetoggle=<F3>
" disable autoindent when pasting text
" source: https://coderwall.com/p/if9mda/automatically-set-paste-mode-in-vim-when-pasting-in-insert-mode
let &t_SI .= "\<Esc>[?2004h"
let &t_EI .= "\<Esc>[?2004l"

function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction

inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()
