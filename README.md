My Super Awesome Vim Files (tm)
===============================

Essentially a slimmed down [Janus](/carlhuda/janus), managed with
Pathogen. See below for a list of plugins/customizations/color schemes.

Installing
==========

On OS X, first install MacVim!

```
brew install macvim # you better be using homebrew *shakes fist*
```

Otherwise, install gvim with your favorite package manager.

Then:

```
cd ~
git clone git://github.com/codykrieger/dotvim.git .vim
cd .vim
./setup.sh
```

In most cases, that'll do it!

## Issues

You might run into an error that says something like this:

```
Vim: Caught deadly signal SEGV...
```

That means your vim/gvim was compiled with Ruby, but ```setup.sh```
compiled Command-T with a different version of Ruby. To fix this, you'll
need to find the version of Ruby your vim/gvim was compiled against
(```(vim|gvim) --version``` and sift through the output), install that,
rubygems, and rake, and then do one of these:

```
cd ~/.vim/bundle/command-t
/path/to/your/rake/gem/binary make
```

Then run vim/gvim again, and you should be okay! If not...just get rid
of Command-T.

Plugins & Customizations
========================

```
align                 # for auto-aligning assignment statements, etc.
coffee-script         # duh, coffeescript
command-t             # textmate-like fuzzy file quick-open thingy
cucumber              # duh, cucumber
delimitMate           # textmate-like parentheses/quote/brace auto-insertion
endwise               # auto-insert end keyword in ruby
fugitive              # for working with git in vim
gist                  # create github gists right from within vim!
git                   # MORE GIT
haml                  # duh, haml
indent-object         # represents code at the same indent level as an object
javascript            # duh, javascript
markdown              # duh, markdown
mustache              # duh, mustache
nerdcommenter         # awesome automagical commenting plugin, mapped to <leader>/
nerdtree              # project drawer! hide/show mapped to <leader>n
puppet                # duh, puppet
rails                 # if you're not using this with rails, you're doing it wrong (tm)
rspec                 # duh, rspec
scala                 # duh, scala
snipmate              # textmate-like snippets
supertab              # SUPERTAB!!!!!
surround              # quoting/parenthesizing made simple
textile               # duh, textile
unimpaired            # handy bracket mappings
```

Color Schemes
=============

```
solarized (default)
color-sampler-pack
molokai
irblack
vividchalk
```

