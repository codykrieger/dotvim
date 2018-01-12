"""""""""""""""""""""""""""""""""
" # GENERAL
"""""""""""""""""""""""""""""""""

" Automatically load changed files
set autoread

" Auto-reload vimrc
autocmd! bufwritepost vimrc source ~/.vim/vimrc
" autocmd! bufwritepost gvimrc source ~/.vim/gvimrc

" Reset leader (default \), lower leader+<key> timeout
let mapleader=","
set timeoutlen=500

" Scrolling. Text selection.
set mouse=a
if !has("nvim")
    set ttymouse=xterm2
endif

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
set wildignore+=*.o,*.obj,.git,*.rbc,*.class,.svn,vendor,node_modules
set wildignore+=*.eot,*.svg,*.ttf,*.woff,*.jpg,*.png,*.gif,*.swp,*.psd
set wildignore+=*/tmp/*,*/Build/*,*/build/*
set completeopt-=preview

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

colorscheme molokai

if has("gui_running")
  if has("mac")
    set gfn=Hack:h14
  endif
endif

"""""""""""""""""""""""""""""""""
" # TEXT, TABS, INDENTATION, ETC.
"""""""""""""""""""""""""""""""""

" Whitespace stuff
set nowrap
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set list listchars=tab:\ \ ,trail:·

function! s:SetUpWrapping()
  set wrap
  set wrapmargin=2
  set textwidth=80
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
" # LINTING/STYLE CHECKING/AUTOCOMPLETE
"""""""""""""""""""""""""""""""""

if has("nvim")
    let g:deoplete#enable_at_startup = 1

    " Allow Tab key to shuffle through the completion popup
    inoremap <silent><expr> <Tab> pumvisible() ? "\<C-n>" : deoplete#mappings#manual_complete()

    " Close the documentation window when completion is done
    autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
endif

"""""""""""""""""""""""""""""""""
" # LANGUAGES/FILETYPES
"""""""""""""""""""""""""""""""""

" load the plugin and indent settings for the detected filetype
filetype plugin indent on

" make uses real tabs
au FileType make setlocal noexpandtab

" Thorfile, Rakefile, Vagrantfile and Gemfile are Ruby
au BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,config.ru,Hulafile}    setlocal ft=ruby
au BufRead,BufNewFile *.html.erb setlocal ft=eruby

" Add json syntax highlighting
au BufNewFile,BufRead *.json setlocal ft=json syntax=javascript

au BufRead,BufNewFile *.txt call s:SetUpWrapping()

" make Python follow PEP8 ( http://www.python.org/dev/peps/pep-0008/ )
au FileType python setlocal sts=4 ts=4 sw=4 tw=79

au FileType glsl setlocal ts=4 sts=4 sw=4 et tw=79

au FileType {objc,objcpp} setlocal ts=4 sts=4 sw=4 et
au BufNewFile,BufRead *.m setlocal ft=objc

au FileType go set noexpandtab
au FileType go nmap <Leader>gr <Plug>(go-rename)
au FileType go nmap <Leader>gi <Plug>(go-info)
au FileType go nmap <Leader>gd <Plug>(go-doc)
au FileType go nmap <Leader>gb <Plug>(go-doc-browser)
au FileType go nmap <Leader>ds <Plug>(go-def-split)
au FileType go nmap <Leader>dv <Plug>(go-def-vertical)
au FileType go nmap <Leader>dt <Plug>(go-def-tab)

au BufRead,BufNewFile *.{md,markdown,mdown,mkd} setlocal ft=markdown

if has("autocmd")
  " language-specific indentation settings
  autocmd FileType c,cpp                      setlocal ts=4 sts=4 sw=4 et tw=80 nowrap
  autocmd FileType sh,csh,tcsh,zsh            setlocal ts=4 sts=4 sw=4 et
  autocmd FileType php,javascript,css         setlocal ts=4 sts=4 sw=4 et
  autocmd FileType text,markdown              setlocal ts=4 sts=4 sw=4 et tw=80 wrap

  autocmd FileType html,xhtml,xml,gohtmltmpl  setlocal ts=4 sts=4 sw=4 et
  autocmd FileType ruby,eruby,yaml            setlocal ts=2 sts=2 sw=2 et
  autocmd FileType scm,sml,lisp               setlocal ts=4 sts=4 sw=4 et tw=80 nowrap

  autocmd FileType changelog                  setlocal ts=4 sts=4 sw=4 et tw=80 wrap

  autocmd FileType vim                        setlocal nowrap

  " language-specific general settings

  " run file
  autocmd FileType php noremap <C-M> :w!<CR>:!php %<CR>
  " check syntax
  autocmd FileType php noremap <C-L> :w!<CR>:!php -l %<CR>
endif

augroup filetype
  au! BufRead,BufNewFile *.proto setfiletype proto
augroup END

" go-vim configuration
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

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
map <C-N> [e
map <C-M> ]e
imap <C-N> <C-O>[e
imap <C-M> <C-O>]e
" Bubble multiple lines
vmap <C-N> [egv
vmap <C-M> ]egv

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

" Select the just-changed (works for just-pasted) text
nnoremap gp `[v`]

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
  set guioptions-=T
endif

"""""""""""""""""""""""""""""""""
" # LOCAL VIM CONFIG
"""""""""""""""""""""""""""""""""

" Include user's local vim config
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif
