Super Awesome Vim Files (tm)
============================

Essentially a slimmed down [Janus](/carlhuda/janus), managed with
[Pathogen](/tpope/vim-pathogen). See below for a list of plugins, 
customizations and color schemes.

Installing
==========

## If on Mac OS X

Install MacVim if you want it (you should)!!

```
brew install macvim # you better be using homebrew *shakes fist*
```

Otherwise, you're set.

## If on another OS

- Have some flavour of Ruby installed
- Install gvim with your favorite package manager (optional)
- Install rake (```[sudo] gem install rake```)

## Then...

```
curl https://raw.github.com/codykrieger/dotvim/master/bootstrap.sh -o - | sh
```

In most cases, that'll do it!

## Ignoring documentation content in submodules

Run this bad boy in your ~/.vim folder:

```
git submodule -q foreach 'echo "git config submodule.$path.ignore" untracked'
```

Copy the lines it outputs, and paste them into your terminal. No more 
annoyingness in `git status`!

## Problem???

If you encounter an error like the following when attempting to run vim or 
gvim:

```
Vim: Caught deadly signal SEGV...
```

Then see the Command-T section at the bottom of the readme, or just uncomment 
lines 2-4 in the ```vimrc``` file to disable Command-T.

Plugins & Customizations
========================

## Plugins

```
align          # for auto-aligning assignment statements, etc.
autoclose      # for closing logical pairs (e.g. '(' and ')', '"', ''', etc.)
coffee-script  # duh, coffeescript
command-t      # textmate-like fuzzy file quick-open thingy. mapped to <super>t and <leader>t
cucumber       # duh, cucumber
endwise        # auto-insert end keyword in ruby
fugitive       # for working with git in vim
gist           # create github gists right from within vim!
git            # MORE GIT
haml           # duh, haml
indent-object  # represents code at the same indent level as an object
javascript     # duh, javascript
markdown       # duh, markdown
mustache       # duh, mustache
nerdcommenter  # awesome automagical commenting plugin, mapped to <leader>/
nerdtree       # project drawer! hide/show mapped to <leader>n
puppet         # duh, puppet
rails          # if you're not using this with rails, you're doing it wrong (tm)
rspec          # duh, rspec
scala          # duh, scala
snipmate       # textmate-like snippets
supertab       # SUPERTAB!!!!!
surround       # quoting/parenthesizing made simple
textile        # duh, textile
unimpaired     # handy bracket mappings
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

Command-T
=========

If you take a look at the first four or so lines of the vimrc, you'll 
notice that I've told Pathogen to disable loading Command-T on non-Mac 
OS X systems. This is because you'll end up with the following error 
unless you perform some trickery:

```
Vim: Caught deadly signal SEGV...
```

That means your vim/gvim was compiled with Ruby, but ```setup.sh```
compiled Command-T with a **different version** of Ruby. To fix this, you'll
need to find the version of Ruby your vim/gvim was compiled against
(```[vim|gvim] --version``` and sift through the output), install that,
rubygems, and rake, and then do one of these:

```
cd ~/.vim/bundle/command-t
/path/to/your/rake/binary make
```

Then run vim/gvim again, and you should be okay! If not...forget about 
Command-T.
