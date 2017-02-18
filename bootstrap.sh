#!/bin/sh

set -e

main() {
    for i in ~/.vim ~/.vimrc ~/.gvimrc ; do
        [ -e $i ] && mv $i $i.old
    done

    git clone git://github.com/codykrieger/dotvim.git ~/.vim

    cd ~/.vim
    script/bootstrap
}

main
