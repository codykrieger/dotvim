" ******* GENERAL *******

set encoding=utf-8

" Auto-reload changes to vimrc
autocmd! bufwritepost vimrc source ~/.vim/vimrc

" Directories for swap files
set backupdir=~/.vim/backup
set directory=~/.vim/backupf

" ******* GUI *******

set title
set number
set ruler
set cursorline
set hlsearch

set termguicolors

colorscheme gruvbox

" Support embedded Lua, Python and Ruby
let g:vimsyn_embed = 'lPr'

" ******* INPUT *******

let mapleader=","
set timeoutlen=300

" Use system clipboard
set clipboard=unnamed

set incsearch
set ignorecase
set smartcase

" Allow arrowing and backspacing across newlines
set whichwrap=bs<>[]

" Allow backspacing over everything in insert mode
set backspace=indent,eol,start

" ******* TEXT EDITING AND DISPLAY *******

set nowrap
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set list listchars=tab:\ \ ,trail:·

set smarttab
set autoindent
set smartindent

" ******* KEY MAPPINGS *******

let NERDTreeIgnore=['\.pyc$', '\.rbc$', '\~$']
map <Leader>n :NERDTreeToggle<CR>

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

" % to bounce from do to end etc.
runtime! macros/matchit.vim

nmap <leader>sp :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

" ******* LINTING AND AUTOCOMPLETE *******

set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.class,.svn,vendor,node_modules
set wildignore+=*.eot,*.svg,*.ttf,*.woff,*.jpg,*.png,*.gif,*.swp,*.psd
set wildignore+=*/tmp/*,*/Build/*,*/build/*
set completeopt-=preview

if has("nvim")
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
                ['<CR>'] = cmp.mapping({
                    i = function(fallback)
                        if cmp.visible() and cmp.get_active_entry() then
                            cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
                        else
                            fallback()
                        end
                    end,
                    s = cmp.mapping.confirm({ select = true }),
                    c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
                }),
                ['<Tab>'] = cmp.mapping(function(fallback)
                    -- This little snippet will confirm with tab, and if no entry is selected, will confirm the first item
                    if cmp.visible() then
                        local entry = cmp.get_selected_entry()
                        if not entry then
                            cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
                        else
                            cmp.confirm()
                        end
                    else
                        fallback()
                    end
                end, {"i","s",}),
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
        require('lspconfig')['ts_ls'].setup{
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

        -- The following Lua snippet was copied pretty much verbatim from:
        -- https://github.com/neovim/nvim-lspconfig#suggested-configuration

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

" ******* LANGUAGE-SPECIFIC SETTINGS *******

" Load plug-in and indent settings for the detected filetype
filetype plugin indent on

au BufRead,BufNewFile *.{md,markdown,mdown,mkd} setlocal ft=markdown
au BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,config.ru,Hulafile,Zosofile,Tridentfile,Podfile} setlocal ft=ruby
au BufRead,BufNewFile *.html.erb setlocal ft=eruby
au BufRead,BufNewFile *.json setlocal ft=json syntax=javascript
au BufRead,BufNewFile *.ksy setlocal ft=yaml sw=2
au BufRead,BufNewFile *.m setlocal ft=objc
au BufRead,BufNewFile *.nomad,*.hcl setlocal ft=hcl
au BufRead,BufNewFile *.proto setlocal ft=proto
au BufRead,BufNewFile *.rbi setlocal ft=ruby
au BufRead,BufNewFile *.trident setlocal ft=ruby
au BufRead,BufNewFile *.tsx,*.jsx setlocal ft=typescriptreact
au BufRead,BufNewFile *.txt setlocal wrap wrapmargin=2 textwidth=80

au FileType c,cpp                      setlocal ts=4 sts=4 sw=4 et tw=80 nowrap
au FileType changelog                  setlocal ts=4 sts=4 sw=4 et tw=80 wrap
au FileType glsl                       setlocal ts=4 sts=4 sw=4 et tw=79
au FileType html,xhtml,xml,gohtmltmpl  setlocal ts=4 sts=4 sw=4 et
au FileType make                       setlocal noexpandtab
au FileType objc,objcpp                setlocal ts=4 sts=4 sw=4 et
au FileType php,javascript,css         setlocal ts=4 sts=4 sw=4 et
au FileType python                     setlocal sts=4 ts=4 sw=4 tw=79
au FileType ruby,eruby,yaml            setlocal ts=2 sts=2 sw=2 et
au FileType scm,sml,lisp               setlocal ts=4 sts=4 sw=4 et tw=80 nowrap
au FileType sh,csh,tcsh,zsh            setlocal ts=4 sts=4 sw=4 et
au FileType terraform,hcl              setlocal ts=2 sts=2 sw=2 et
au FileType text,markdown              setlocal ts=4 sts=4 sw=4 et tw=80 wrap
au FileType vim                        setlocal nowrap

au FileType go set noexpandtab
au FileType go nmap <Leader>gr <Plug>(go-rename)
au FileType go nmap <Leader>gi <Plug>(go-info)
au FileType go nmap <Leader>gd <Plug>(go-doc)
au FileType go nmap <Leader>gb <Plug>(go-doc-browser)
au FileType go nmap <Leader>ds <Plug>(go-def-split)
au FileType go nmap <Leader>dv <Plug>(go-def-vertical)
au FileType go nmap <Leader>dt <Plug>(go-def-tab)

" ******* MISCELLANEOUS PLUG-IN CONFIGURATION *******

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

" ******* EPILOGUE *******

" Include user's local vim config
if filereadable(expand("~/.vimrc.local"))
    source ~/.vimrc.local
endif
