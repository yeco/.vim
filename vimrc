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
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set autoindent

set list listchars=tab:\ \ ,trail:·

" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase
set showmatch

" Tab completion
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc

" Status bar
set laststatus=2

" Make Vim ignore lines when going up or down
nnoremap j gj
nnoremap k gk

" Make x store in the same register
noremap x "_x

" NERDTree configuration
let NERDTreeIgnore=['\.rbc$', '\~$']
map <Leader>n :NERDTreeToggle<CR>

" Command-T configuration
let g:CommandTMaxHeight=20

" Ack configuration
nnoremap <leader>a :Ack 
let g:ackprg="ack-grep -H --nocolor --nogroup --column"

" Strip all trailing whitespace in the current file
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

" Sort CSS properties alphabetically
nnoremap <leader>S ?{<CR>jV/^\s*\}?$<CR>k:sort<CR>:noh<CR>

" CoffeeScript compile
let coffee_compile_on_save = 1

" ZoomWin configuration
map <Leader>z :ZoomWin<CR>

" CTags
map <Leader>rt :!ctags --extra=+f -R *<CR><CR>

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
  map <buffer> <Leader>p :Mm <CR>
endfunction

" make and python use real tabs
au FileType make                                     set noexpandtab
au FileType python                                   set noexpandtab

" Thorfile, Rakefile and Gemfile are Ruby
au BufRead,BufNewFile {Gemfile,Rakefile,Thorfile,config.ru}    set ft=ruby

" md, markdown, and mk are markdown and define buffer-local preview
au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn} call s:setupMarkup()

au BufRead,BufNewFile *.txt call s:setupWrapping()

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" load the plugin and indent settings for the detected filetype
filetype plugin indent on

" Opens an edit command with the path of the currently edited file filled in
" Normal mode: <Leader>e
map <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

" Opens a tab edit command with the path of the currently edited file filled in
" Normal mode: <Leader>t
map <Leader>te :tabe <C-R>=expand("%:p:h") . "/" <CR>

" Fast switching between tabs
map <Leader>. :tabn<CR>

" Open a terminal in the current directory
map <Leader>gt :!gnome-terminal --working-directory=<C-R>=expand("%:p:h") <CR> <CR> <CR>

" Inserts the path of the currently edited file into a command
" Command mode: Ctrl+P
cmap <C-P> <C-R>=expand("%:p:h") . "/" <CR>

" Easily edit this file
nnoremap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<cr>
