" Disable stupid annoying visual bell with gvim
autocmd VimEnter * set vb t_vb=

" Set default window size
set lines=35 columns=110

" Adjust viewports to the same size
map <Leader>= <C-w>=
imap <Leader>= <Esc> <C-w>=

if has("gui_macvim")
  " Fullscreen takes up entire screen
  set fuoptions=maxhorz,maxvert

  " Command-T for CtrlP
  macmenu &File.New\ Tab key=<D-T>
  map <D-t> :CtrlP<CR>
  imap <D-t> <Esc>:CtrlP<CR>

  " Command-Return for fullscreen
  macmenu Window.Toggle\ Full\ Screen\ Mode key=<D-CR>

  " Command-Shift-F for Ack
  map <D-F> :Ack<space>

  " Command-][ to increase/decrease indentation
  vmap <D-]> >gv
  vmap <D-[> <gv

  " Map Command-# to switch tabs
  map  <D-0> 0gt
  imap <D-0> <Esc>0gt
  map  <D-1> 1gt
  imap <D-1> <Esc>1gt
  map  <D-2> 2gt
  imap <D-2> <Esc>2gt
  map  <D-3> 3gt
  imap <D-3> <Esc>3gt
  map  <D-4> 4gt
  imap <D-4> <Esc>4gt
  map  <D-5> 5gt
  imap <D-5> <Esc>5gt
  map  <D-6> 6gt
  imap <D-6> <Esc>6gt
  map  <D-7> 7gt
  imap <D-7> <Esc>7gt
  map  <D-8> 8gt
  imap <D-8> <Esc>8gt
  map  <D-9> 9gt
  imap <D-9> <Esc>9gt

  " Command-Option-ArrowKey to switch viewports
  map <D-M-Up> <C-w>k
  imap <D-M-Up> <Esc> <C-w>k
  map <D-M-Down> <C-w>j
  imap <D-M-Down> <Esc> <C-w>j
  map <D-M-Right> <C-w>l
  imap <D-M-Right> <Esc> <C-w>l
  map <D-M-Left> <C-w>h
  imap <D-M-Left> <C-w>h

endif

" Don't beep
set visualbell

" Start without the toolbar
set guioptions-=T

" If we go fullscreen, use all the room.
" set fuopt=maxvert,maxhorz

" Stupid blinking cursor.
set gcr=n:blinkon0

" Disable the right and left scroll bar.
set guioptions-=r
set guioptions-=L

" Include user's local vim config
if filereadable(expand("~/.gvimrc.local"))
  source ~/.gvimrc.local
endif
