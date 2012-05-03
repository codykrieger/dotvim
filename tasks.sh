#!/bin/bash

# Simple Rakefile-esque task runner.
# Call it like this:
#
#   ./tasks.sh pull update_docs link_vimrc
#
# or just:
#
#   ./tasks.sh
#
# which will execute the pull and link_vimrc tasks.

submodules () {
    echo "Updating submodules..."
    git submodule update --init > /dev/null
    git submodule update > /dev/null
}

clean () {
    git clean -dfx
}

update_docs () {
    echo "Ignoring documentation content in submodules..."
    # git submodule -q foreach 'echo "git config submodule.$path.ignore untracked" >> ./temp.sh'

    # split output of "git submodule" by column (assuming single space delimiter)
    # and iterate through the submodule paths (third column)
    #
    # a typical git submodule output line looks like this (minus the quotes):
    # " e799b8ead5a7acb1c02c941cb6a17201be0df88a bundle/zencoding (heads/master)"
    for i in $(git submodule | tr -s ' ' | cut -d ' ' -f 3)
    do
        git config submodule.$i.ignore untracked
    done
}

link_vimrc () {
    echo "Linking ~/.vimrc and ~/.gvimrc..."
    ln -is $PWD/vimrc ~/.vimrc
    ln -is $PWD/gvimrc ~/.gvimrc
}

pull () {
    echo "Pulling latest from $(git config remote.origin.url)..."
    git pull

    submodules
}

install () {
    echo "Installing VIM bootstrap of awesomesauce..."
    pull
    update_docs
    link_vimrc
}

if [ $# -gt 0 ]
then
    for i in $@
    do
        [ "`type -t $i`" == "function" ] && $i || echo "No task named $i."
    done
else
    pull
    update_docs
fi

