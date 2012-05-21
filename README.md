Super Awesome Vim Files (tm)
============================

Essentially a slimmed down [Janus](/carlhuda/janus), managed with
[Pathogen](/tpope/vim-pathogen). See below for a list of plugins,
customizations and color schemes.

Installing
==========

Bootstrap'd!

```
curl https://raw.github.com/codykrieger/dotvim/master/bootstrap.sh -o - | sh
```

In most cases, that'll do it! If you've got gvim/macvim installed, even better.

Plugins & Customizations
========================

## Plugins

```
ack            # for ack-ing within a project
align          # for auto-aligning assignment statements, etc.
closetag-vim   # for auto-closing html, xml tags
ctrlp          # textmate-like fuzzy file quick-open thingy. mapped to <super>t and ctrl-p
endwise        # auto-insert end keyword in ruby
fugitive       # for working with git in vim
gist           # create github gists right from within vim!
git            # MORE GIT
indent-object  # represents code at the same indent level as an object
nerdcommenter  # awesome automagical commenting plugin, mapped to <leader>/
nerdtree       # project drawer! hide/show mapped to <leader>n
rails          # if you're not using this with rails, you're doing it wrong (tm)
snipmate       # textmate-like snippets
supertab       # SUPERTAB!!!!!
surround       # quoting/parenthesizing made simple
unimpaired     # handy bracket mappings
zencoding      # awesome html fanciness, look it up
```

## Syntaxes

```
coffee-script
cucumber
haml
jade
javascript
markdown
mustache
puppet
rspec
ruby (updated)
scala
slim
stylus
textile
```

## Customizations

- Leader set to comma (,), not backslash (\\)
- Status bar on
- Ruler on (col/row display in status bar)
- Default tabs set to spaces, width 2
- Remembers last location in a given file
- Real tabs for Makefiles
- 4-space tabs for Python files
- Automagical, syntax-aware auto-indent
- \<leader\>e autocompletion to the current dir to edit a file
- \<leader\>te autocompletion to the current dir to edit a file in a new
  tab
- ctrl-up and ctrl-down to "bubble" lines up and down in normal and
  visual modes
- F1 remapped to :nohl to turn off search highlighting when you're done
  searching
- ~/.vim/backup directory for holding .swp files
- ctrl-k for deleting lines (dd command)
- \<leader\>tn to switch to the next tab, \<leader\>tp for previous tab

That's most of it. The rest of the customizations are mainly GUI tweaks,
etc. Take a look at the vimrc/gvimrc files for more info. They're pretty
decently commented.

Color Schemes
=============

```
solarized (default)
color-sampler-pack
molokai
irblack
vividchalk
```

