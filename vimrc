" disable command-t for non-os x systems for the time being
" if !has('mac')
"   let g:pathogen_disabled = ['command-t']
" endif

" Scrolling. Text selection.
set mouse=a

" delimitmate is stupid and broken
" snipmate makes backspace do weird shit
" autoclose sucks and is broken, too
let g:pathogen_disabled = ['delimitmate', 'snipmate', 'autoclose']

" pathogen magic
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

" reset leader (default \)
let mapleader=","

" screw vi
set nocompatible

set ruler
syntax on

" Set encoding
set encoding=utf-8

" Whitespace stuff
set nowrap
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set list listchars=tab:\ \ ,trail:·

" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

" Be able to arrow key and backspace across newlines
set whichwrap=bs<>[]

" Tab completion
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.class,.svn,vendor/gems/*

" Status bar
set laststatus=2

" NERDTree configuration
let NERDTreeIgnore=['\.pyc$', '\.rbc$', '\~$']
map <Leader>n :NERDTreeToggle<CR>

" Command-T configuration
let g:CommandTMaxHeight=20

" Remember last location in file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif
endif

function s:setupWrapping()
  set wrap
  set wrapmargin=2
  set textwidth=72
endfunction

" make uses real tabs
au FileType make set noexpandtab

" Thorfile, Rakefile, Vagrantfile and Gemfile are Ruby
au BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,config.ru}    set ft=ruby

" add json syntax highlighting
au BufNewFile,BufRead *.json set ft=javascript

au BufRead,BufNewFile *.txt call s:setupWrapping()

" make Python follow PEP8 ( http://www.python.org/dev/peps/pep-0008/ )
au FileType python set softtabstop=4 tabstop=4 shiftwidth=4 textwidth=79

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

" screw help
map <F1> :nohl<CR>
imap <F1> <ESC>:nohl<CR> i

" OMG -- for when you forget to sudo vim ...
" ...actually wtf it totally doesn't work
" cmap w!! %!sudo tee > /dev/null %

" gist-vim defaults
if has("mac")
  let g:gist_clip_command = 'pbcopy'
elseif has("unix")
  let g:gist_clip_command = 'xclip -selection clipboard'
endif
let g:gist_detect_filetype = 1
let g:gist_open_browser_after_post = 1

" Use modeline overrides
set modeline
set modelines=10

" Default color scheme
" color desert

" Directories for swp files
set backupdir=~/.vim/backup
set directory=~/.vim/backup

" MacVIM shift+arrow-keys behavior (required in .vimrc)
let macvim_hig_shift_movement = 1

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

if has("gui_running")
  colorscheme solarized
  set bg=light
  if has("mac")
    set gfn=Monaco:h13
  endif
else
  colorscheme desert256
endif

" % to bounce from do to end etc.
runtime! macros/matchit.vim

" Show (partial) command in the status line
set showcmd

if has("autocmd")
  " language-specific indentation settings
  autocmd FileType c,cpp               setlocal ts=4 sts=4 sw=4 et tw=80 nowrap
  autocmd FileType sh,csh,tcsh,zsh     setlocal ts=4 sts=4 sw=4 et
  autocmd FileType php,javascript,css  setlocal ts=4 sts=4 sw=4 et
  autocmd FileType text,txt,mkd        setlocal ts=4 sts=4 sw=4 et tw=80 wrap

  autocmd FileType html,xhtml,xml      setlocal ts=2 sts=2 sw=2 et
  autocmd FileType ruby,eruby,yaml     setlocal ts=2 sts=2 sw=2 et
  autocmd FileType scm,sml,lisp        setlocal ts=2 sts=2 sw=2 et tw=80 nowrap

  " language-specific general settings

  " run file
  autocmd FileType php noremap <C-M> :w!<CR>:!php %<CR>
  " check syntax
  autocmd FileType php noremap <C-L> :w!<CR>:!php -l %<CR>
endif

syntax enable "Enable syntax hl
set t_Co=256
if has("gui_running") || $TERM=="xterm-256color"
  set t_Co=256
  set guioptions-=T
  set nonu
else
  "Had to do this in order to continue to allow syntax highlighting on non-
  "xterm-256color and non-GUI vims.  On OS X, the entire file flashes
  "if this is not set.
  set t_Co=256
  set nonu
endif

" Line numbers
set number

" More auto indentation/tab magic
set shiftround
set copyindent
set autoindent
set smarttab

" Include user's local vim config
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif

