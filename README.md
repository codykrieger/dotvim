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
align
coffee-script
command-t
cucumber
delimitMate
en`wise
fugitive
gist
git
haml
indent-object
javascript
markdown
mustache
nerdcommenter
nerdtree
puppet
rails
rspec
scala
snipmate
supertab
surround
textile
unimpaired
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

