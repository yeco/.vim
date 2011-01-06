call pathogen#runtime_append_all_bundles()

" Environment
set nocompatible
set encoding=utf-8
set showmode
set showcmd
set visualbell
set mouse=a
set ruler
set number
set clipboard=unnamed
set modelines=0
set cul
set ttyfast
set term=xterm-256color
color jellybeans

" Vim 7.3
if exists("&colorcolumn")
    set colorcolumn=85
endif

" Change leader key to , instead of \ (easier to type)
let mapleader=","

" Use syntax highlighting
syntax on

" Enable word wrapping
set wrap

" Show addition lines below or above the cursor when scrolling
set scrolloff=3

" Expand all tabs to four spaces
set tabstop=3
set shiftwidth=3
set softtabstop=3
set expandtab
set autoindent

" Show · for trailing space, \ \ for trailing tab
set list listchars=tab:\ \ ,trail:·

" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase
set showmatch

" Quickly clear search highlight
nnoremap <leader><space> :noh<cr>

" Tab completion
set wildmode=list:longest,list:full
set wildignore+=*.o,.git

" Status bar
set laststatus=2

" Make Vim ignore lines when going up or down
nnoremap j gj
nnoremap k gk

" Make x store in the same register
noremap x "_x

" NERDTree configuration, ignore files ending in ~
let NERDTreeIgnore=['\~$']
map <leader>n :NERDTreeToggle<cr>

" Command-T configuration
let g:CommandTMaxHeight=20

" Ack configuration
nnoremap <leader>a :Ack 
let g:ackprg="ack-grep -H --nocolor --nogroup --column"

" Strip all trailing whitespace in the current file
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<cr>

" Sort CSS properties alphabetically
nnoremap <leader>S ?{<cr>jV/^\s*\}<cr>k:sort<cr>:noh<cr>

" CoffeeScript compile
let coffee_compile_on_save = 1

" ZoomWin configuration
map <leader>z :ZoomWin<cr>

" CTags
map <leader>rt :!ctags --extra=+f -R *<cr><cr>

" Remember last location in file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif
endif

function s:setupWrapping()
  set wrap
  set wm=2
  set textwidth=72
endfunction

function s:setupMarkup()
  call s:setupWrapping()
  map <buffer> <leader>p :Mm <cr>
endfunction

" make and python use real tabs
au FileType make                                     set noexpandtab
au FileType python                                   set noexpandtab

" md, markdown, and mk are markdown and define buffer-local preview
au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn} call s:setupMarkup()

" txt files have special wrapping
au BufRead,BufNewFile *.txt call s:setupWrapping()

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" load the plugin and indent settings for the detected filetype
filetype plugin indent on

" Opens an edit command with the path of the currently edited file filled in
" Normal mode: <leader>e
map <leader>e :e <C-R>=expand("%:p:h") . "/" <cr>

" Opens a tab edit command with the path of the currently edited file filled in
" Normal mode: <leader>t
map <leader>te :tabe <C-R>=expand("%:p:h") . "/" <cr>

" Fast switching between tabs
map <leader>. :tabn<cr>

" Fast switching between windows
map <leader>, <C-w>w

" Open a terminal in the current directory
map <leader>gt :!gnome-terminal --working-directory=<C-R>=expand("%:p:h") <cr> <cr> <cr>

" Inserts the path of the currently edited file into a command
" Command mode: Ctrl+P
cmap <C-P> <C-R>=expand("%:p:h") . "/" <cr>

" Easily edit this file
nnoremap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<cr>
