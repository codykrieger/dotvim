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

" Copy/paste!
set clipboard=unnamed

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
set t_Co=256

if empty($TMUX)
    if has("nvim")
        "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
        let $NVIM_TUI_ENABLE_TRUE_COLOR=1
    endif
    if has("+termguicolors")
        set termguicolors
    endif
endif

syntax on
syntax enable

colorscheme xcodedark

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
    " The following Lua snippet was copied pretty much verbatim from:
    " https://github.com/neovim/nvim-lspconfig#suggested-configuration

    lua <<EOF
        local cmp = require'cmp'

        cmp.setup({
            snippet = {
                -- REQUIRED - you must specify a snippet engine
                expand = function(args)
                    -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
                    -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                    -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
                    vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
                end,
            },
            window = {
                -- completion = cmp.config.window.bordered(),
                -- documentation = cmp.config.window.bordered(),
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<C-e>'] = cmp.mapping.abort(),
                ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                ['<Tab>'] = function(fallback)
                    if not cmp.select_next_item() then
                        if vim.bo.buftype ~= 'prompt' and has_words_before() then
                            cmp.complete()
                        else
                            fallback()
                        end
                    end
                end,

                ['<S-Tab>'] = function(fallback)
                    if not cmp.select_prev_item() then
                        if vim.bo.buftype ~= 'prompt' and has_words_before() then
                            cmp.complete()
                        else
                            fallback()
                        end
                    end
                end,
            }),
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                -- { name = 'vsnip' }, -- For vsnip users.
                -- { name = 'luasnip' }, -- For luasnip users.
                { name = 'ultisnips' }, -- For ultisnips users.
                -- { name = 'snippy' }, -- For snippy users.
            }, {
                { name = 'buffer' },
            })
        })

        -- Set up lspconfig.
        local capabilities = require('cmp_nvim_lsp').default_capabilities()

        local util = require "lspconfig/util"

        require('lspconfig')['svelte'].setup{
            capabilities = capabilities
        }
        require('lspconfig')['tsserver'].setup{
            capabilities = capabilities
        }
        require('lspconfig')['zls'].setup{
            capabilities = capabilities
        }
        require('lspconfig')['gopls'].setup{
            capabilities = capabilities
            -- settings = {
            --     gopls = {
            --         analyses = {
            --             -- nilness = true,
            --             -- unusedparams = true,
            --         },
            --         -- staticcheck = true,
            --     },
            -- }
        }
        require('lspconfig')['rust_analyzer'].setup{
            capabilities = capabilities,
            root_dir = util.root_pattern("Cargo.toml", ".git"),
            settings = {
                ["rust-analyzer"] = {
                    imports = {
                        granularity = {
                            group = "module",
                        },
                        prefix = "self",
                    },
                    cargo = {
                        buildScripts = {
                            enable = true,
                        },
                    },
                    procMacro = {
                        enable = true
                    },
                }
            }
        }

        -- Global mappings.
        -- See `:help vim.diagnostic.*` for documentation on any of the below functions
        vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
        vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
        vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
        vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

        -- Use LspAttach autocommand to only map the following keys
        -- after the language server attaches to the current buffer
        vim.api.nvim_create_autocmd('LspAttach', {
          group = vim.api.nvim_create_augroup('UserLspConfig', {}),
          callback = function(ev)
            -- Enable completion triggered by <c-x><c-o>
            -- vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

            -- Buffer local mappings.
            -- See `:help vim.lsp.*` for documentation on any of the below functions
            local opts = { buffer = ev.buf }
            vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
            vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
            vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
            vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
            vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
            vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
            vim.keymap.set('n', '<space>wl', function()
              print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            end, opts)
            vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
            vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
            vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
            vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
            vim.keymap.set('n', '<space>f', function()
              vim.lsp.buf.format { async = true }
            end, opts)
          end,
        })
EOF
endif

"""""""""""""""""""""""""""""""""
" # LANGUAGES/FILETYPES
"""""""""""""""""""""""""""""""""

" load the plugin and indent settings for the detected filetype
filetype plugin indent on

" make uses real tabs
au FileType make setlocal noexpandtab

" Thorfile, Rakefile, Vagrantfile and Gemfile are Ruby
au BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,config.ru,Hulafile,Zosofile,Tridentfile,Podfile} setlocal ft=ruby
au BufRead,BufNewFile *.trident setlocal ft=ruby
au BufRead,BufNewFile *.rbi setlocal ft=ruby
au BufRead,BufNewFile *.html.erb setlocal ft=eruby

" Add json syntax highlighting
au BufNewFile,BufRead *.json setlocal ft=json syntax=javascript

au BufRead,BufNewFile *.txt call s:SetUpWrapping()

" make Python follow PEP8 ( http://www.python.org/dev/peps/pep-0008/ )
au FileType python setlocal sts=4 ts=4 sw=4 tw=79

au FileType glsl setlocal ts=4 sts=4 sw=4 et tw=79

au FileType {objc,objcpp} setlocal ts=4 sts=4 sw=4 et
au BufNewFile,BufRead *.m setlocal ft=objc

au BufRead,BufNewFile *.ksy setlocal ft=yaml sw=2

au FileType go set noexpandtab
au FileType go nmap <Leader>gr <Plug>(go-rename)
au FileType go nmap <Leader>gi <Plug>(go-info)
au FileType go nmap <Leader>gd <Plug>(go-doc)
au FileType go nmap <Leader>gb <Plug>(go-doc-browser)
au FileType go nmap <Leader>ds <Plug>(go-def-split)
au FileType go nmap <Leader>dv <Plug>(go-def-vertical)
au FileType go nmap <Leader>dt <Plug>(go-def-tab)

au BufRead,BufNewFile *.{md,markdown,mdown,mkd} setlocal ft=markdown
au BufNewFile,BufRead *.tsx,*.jsx set ft=typescriptreact
au BufNewFile,BufRead *.nomad,*.hcl set ft=hcl

" language-specific indentation settings
au FileType c,cpp                      setlocal ts=4 sts=4 sw=4 et tw=80 nowrap
au FileType sh,csh,tcsh,zsh            setlocal ts=4 sts=4 sw=4 et
au FileType php,javascript,css         setlocal ts=4 sts=4 sw=4 et
au FileType text,markdown              setlocal ts=4 sts=4 sw=4 et tw=80 wrap

au FileType html,xhtml,xml,gohtmltmpl  setlocal ts=4 sts=4 sw=4 et
au FileType ruby,eruby,yaml            setlocal ts=2 sts=2 sw=2 et
au FileType scm,sml,lisp               setlocal ts=4 sts=4 sw=4 et tw=80 nowrap

au FileType changelog                  setlocal ts=4 sts=4 sw=4 et tw=80 wrap

au FileType vim                        setlocal nowrap

au FileType terraform,hcl              setlocal ts=2 sts=2 sw=2 et

" language-specific general settings

" run file
au FileType php noremap <C-M> :w!<CR>:!php %<CR>

" check syntax
au FileType php noremap <C-L> :w!<CR>:!php -l %<CR>

augroup filetype
  au! BufRead,BufNewFile *.proto setfiletype proto
augroup END

" go-vim configuration
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

" NERDCommenter configuration
let g:NERDSpaceDelims = 1
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1
let g:NERDDefaultAlign = 'left'
let g:NERDCustomDelimiters = { 'c': { 'left': '//', 'right': '', 'leftAlt': '/*', 'rightAlt': '*/' } }

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

" Map fzf to Ctrl-P for fuzzy file finding via fzf \o/
imap <C-P> <C-O>:Files<CR>
nmap <C-P> :Files<CR>

" Map :Rg to Ctrl-L for find-in-project via fzf-vim and ripgrep
imap <C-L> <C-O>:Rg 
nmap <C-L> :Rg 

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

nmap <leader>sp :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

"""""""""""""""""""""""""""""""""
" # GUI STUFF
"""""""""""""""""""""""""""""""""

" Use modeline overrides at the top of files if present
set modeline

" Only look at this number of lines for modeline
set modelines=10

"""""""""""""""""""""""""""""""""
" # LOCAL VIM CONFIG
"""""""""""""""""""""""""""""""""

" Include user's local vim config
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif
