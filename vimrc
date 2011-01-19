filetype off
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

" Environment
set nocompatible " don't limit vim trying to support vi
set encoding=utf-8 " set encoding to utf-8
set showmode " show which mode
set showcmd " show last command
set visualbell " flash screen for invalid operation
set mouse=a " allow for full mouse support
set ruler " show ruler
set clipboard=unnamed
set modelines=0 " disabled for security
set cul " highlight line the cursor is on
set ttyfast " fast terminal connection is in use, more redraws allowed
set nolazyredraw " prevent redraw while executing macros
set autowriteall " write changes when switching buffers

set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%)
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P

set term=xterm-256color " allow for more color
color jellybeans

" Vim 7.3
if exists("&colorcolumn")
   set colorcolumn=115

   " Persistent undo setup
   set undodir=~/.vim/undodir
   set undofile

   " Relative line numbers
   set relativenumber
else
   set number
endif

" Change leader key to , instead of \ (easier to type)
let mapleader=","

" Fast saving
nmap <leader>w :up<cr>

" Allow saving when you forgot sudo
cmap w!! w !sudo tee % >/dev/null

" Fast switching between tabs
map <leader>. :tabn<cr>

" Fast switching between prev buffer
map <leader>b :b#<cr>

" Fast switching between windows
map <leader>, <C-w>w
map <leader>h <C-w>h
map <leader>j <C-w>j
map <leader>k <C-w>k
map <leader>l <C-w>l

" Fast switching out of insert mode
imap jj <Esc>

" Use syntax highlighting
syntax on

" Disable word wrapping
set nowrap

" Show addition lines below or above the cursor when scrolling
set scrolloff=3

" Expand all tabs to two spaces
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set autoindent

" Show · for trailing space, \ \ for trailing tab
set list listchars=tab:\ \ ,trail:·

" Searching
set hlsearch " highlight search result
set incsearch " show matches while typing
set ignorecase " ignore case when searching
set smartcase " honor case if any uppercase letters are used
set showmatch " jump to match if visible
set magic " make regular expressions follow more closely to perl conventions

" Fast clear highlight
nnoremap <leader><space> :noh<cr>

" Prevent hitting F1 (:h) when trying to ESC
inoremap<F1> <ESC>
nnoremap<F1> <ESC>
vnoremap<F1> <ESC>

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

" CoffeeScript compile
let coffee_compile_on_save = 1

" Syntastic configuration
nnoremap <leader>err :Errors<cr><C-W>w

" ZoomWin configuration
map <leader>z :ZoomWin<cr>

" delimitMate configuration
let loaded_delimitMate = 0
let delimitMate_expand_cr = 1

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

" Open a terminal in the current directory
map <leader>gt :!gnome-terminal --working-directory=<C-R>=expand("%:p:h") <cr> <cr> <cr>

" Inserts the path of the currently edited file into a command
" Command mode: Ctrl+P
cmap <C-P> <C-R>=expand("%:p:h") . "/" <cr>

" Strip all trailing whitespace in the current file
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<cr>

" Sort CSS properties alphabetically
nnoremap <leader>S ?{<cr>jV/^\s*\}<cr>k:sort<cr>:noh<cr>

" Automatically save file on focus change
au FocusLost * :up

" Easily edit this file
nnoremap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<cr>

" Source this file after editing
au! BufWritePost .vimrc source ~/.vimrc
