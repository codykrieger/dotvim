"""""""""""""""""""""""""""""""""
" # PATHOGEN
"""""""""""""""""""""""""""""""""

let g:pathogen_disabled = []
let g:pathogen_disabled += ['vim-smartinput', 'nerdtree'] ", 'closetag-vim', 'supertab']

" pathogen magic
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

"""""""""""""""""""""""""""""""""
" # GENERAL
"""""""""""""""""""""""""""""""""

" Automatically load changed files
set autoread

" Auto-reload vimrc
autocmd! bufwritepost vimrc source ~/.vim/vimrc
" autocmd! bufwritepost gvimrc source ~/.vim/gvimrc

" reset leader (default \)
let mapleader=","

" Scrolling. Text selection.
set mouse=a

" We don't like vi
set nocompatible

" Add the g flag to search/replace by default
set gdefault

" Show the filename in the window titlebar
set title

" Set encoding
set encoding=utf-8

" Directories for swp files
set backupdir=~/.vim/backup
set directory=~/.vim/backupf

"""""""""""""""""""""""""""""""""
" # UI
"""""""""""""""""""""""""""""""""

" Line numbers
set number

" Always show current position
set ruler

" Highlight current line
set cursorline

" Highlight search matches
set hlsearch
" Act like search in modern web browsers
set incsearch
" Ignore case when searching
set ignorecase
set smartcase

" Turn on magic for regexes
set magic

" Show matching braces when text indicator is over them
" set showmatch

" Be able to arrow key and backspace across newlines
set whichwrap=bs<>[]

" Tab completion
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.class,.svn,vendor/gems/*
set wildignore+=*.eot,*.svg,*.ttf,*.woff,*.jpg,*.png,*.gif,*.swp,*.psd

" Status bar
set laststatus=2

" NERDTree configuration
let NERDTreeIgnore=['\.pyc$', '\.rbc$', '\~$']
map <Leader>n :NERDTreeToggle<CR>

" Remember last location in file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif
endi

" Show (partial) command in the status line
set showcmd

"""""""""""""""""""""""""""""""""
" # COLORS/FONTS
"""""""""""""""""""""""""""""""""

" Syntax highlighting!
syntax on
syntax enable

if has("gui_running")
  colorscheme solarized
  set bg=light
  if has("mac")
    set gfn=Monaco:h12
  endif
else
  colorscheme desert256
endif

"""""""""""""""""""""""""""""""""
" # TEXT, TABS, INDENTATION, ETC.
"""""""""""""""""""""""""""""""""

" Whitespace stuff
set nowrap
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set list listchars=tab:\ \ ,trail:·

function! s:SetupWrapping()
  set wrap
  set wrapmargin=2
  set textwidth=72
endfunction

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" More auto indentation/tab magic
" set shiftround
" set copyindent
set smarttab
set autoindent
set smartindent

"""""""""""""""""""""""""""""""""
" # LANGUAGES/FILETYPES
"""""""""""""""""""""""""""""""""

" load the plugin and indent settings for the detected filetype
filetype plugin indent on

" make uses real tabs
au FileType make set noexpandtab

" Thorfile, Rakefile, Vagrantfile and Gemfile are Ruby
au BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,config.ru}    set ft=ruby
au BufRead,BufNewFile *.html.erb set ft=eruby

" Add json syntax highlighting
au BufNewFile,BufRead *.json set ft=json syntax=javascript

au BufRead,BufNewFile *.txt call s:SetupWrapping()

" make Python follow PEP8 ( http://www.python.org/dev/peps/pep-0008/ )
au FileType python set softtabstop=4 tabstop=4 shiftwidth=4 textwidth=79

if has("autocmd")
  " language-specific indentation settings
  autocmd FileType c,cpp                    setlocal ts=4 sts=4 sw=4 et tw=80 nowrap
  autocmd FileType sh,csh,tcsh,zsh          setlocal ts=4 sts=4 sw=4 et
  autocmd FileType php,javascript,css       setlocal ts=4 sts=4 sw=4 et
  autocmd FileType text,txt,mkd,md,mdown    setlocal ts=4 sts=4 sw=4 et tw=80 wrap

  autocmd FileType html,xhtml,xml           setlocal ts=2 sts=2 sw=2 et
  autocmd FileType ruby,eruby,yaml          setlocal ts=2 sts=2 sw=2 et
  autocmd FileType scm,sml,lisp             setlocal ts=2 sts=2 sw=2 et tw=80 nowrap

  autocmd FileType changelog                setlocal ts=4 sts=4 sw=4 et tw=80 wrap

  " language-specific general settings

  " run file
  autocmd FileType php noremap <C-M> :w!<CR>:!php %<CR>
  " check syntax
  autocmd FileType php noremap <C-L> :w!<CR>:!php -l %<CR>
endif

"""""""""""""""""""""""""""""""""
" # SHORTCUTS/MAPPINGS
"""""""""""""""""""""""""""""""""

" Opens an edit command with the path of the currently edited file filled in
" Normal mode: <Leader>e
map <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

" Opens a tab edit command with the path of the currently edited file filled in
" Normal mode: <Leader>t
map <Leader>te :tabe <C-R>=expand("%:p:h") . "/" <CR>

" Inserts the path of the currently edited file into a command
" Command mode: Ctrl+P
cmap <C-P> <C-R>=expand("%:p:h") . "/" <CR>

" Unimpaired configuration
" Bubble single lines
nmap <C-Up> [e
nmap <C-Down> ]e
" Bubble multiple lines
vmap <C-Up> [egv
vmap <C-Down> ]egv

" NERDCommenter
map <Leader>/ <plug>NERDCommenterToggle

" Remove trailing whitespace from all lines in the current buffer
command! Rtrim call <SID>RightTrim()
function! <SID>RightTrim()
  :% s/\s*$//g
  nohl
endfunction

" Remap help to clearing the search highlight
map <F1> :nohl<CR>
imap <F1> <ESC>:nohl<CR> i

" Delete line with CTRL-K
map  <C-K>      dd
imap <C-K>      <C-O>dd

" Format the current paragraph according to
" the current 'textwidth' with CTRL-J:
nmap <C-J>      gqap
vmap <C-J>      gq
imap <C-J>      <C-O>gqap

" Tabs
map <Leader>tp :tabp<CR>
map <Leader>tn :tabnext<CR>

" Bash-like home/end key mappings
cnoremap <C-A> <Home>
cnoremap <C-E> <End>

" MacVIM shift+arrow-keys behavior (required in .vimrc)
let macvim_hig_shift_movement = 1

" gist-vim defaults
if has("mac")
  let g:gist_clip_command = 'pbcopy'
elseif has("unix")
  let g:gist_clip_command = 'xclip -selection clipboard'
endif
let g:gist_detect_filetype = 1
let g:gist_open_browser_after_post = 1

" % to bounce from do to end etc.
runtime! macros/matchit.vim

"""""""""""""""""""""""""""""""""
" # GUI STUFF
"""""""""""""""""""""""""""""""""

" Use modeline overrides at the top of files if present
set modeline
" Only look at this number of lines for modeline
set modelines=10

set t_Co=256
if has("gui_running") || $TERM=="xterm-256color"
  set t_Co=256
  set guioptions-=T
else
  "Had to do this in order to continue to allow syntax highlighting on non-
  "xterm-256color and non-GUI vims.  On OS X, the entire file flashes
  "if this is not set.
  set t_Co=256
endif

"""""""""""""""""""""""""""""""""
" # LOCAL VIM CONFIG
"""""""""""""""""""""""""""""""""

" Include user's local vim config
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif

