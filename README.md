# dotvim

A modern, lightweight configuration for neovim.

## prerequisites

- neovim + the python2/3 neovim bindings

If you're on macOS, the easiest way to acquire the right versions of things is
to use [Homebrew][homebrew]:

neovim:

```bash
brew install neovim
brew install python3
pip3 install neovim
```

## installing

```
curl https://raw.githubusercontent.com/codykrieger/dotvim/master/bootstrap.sh -o - | sh
```

## what makes this vim config special

### notable features

- Leader key set to comma `,`, not backslash `\`
- Syntax-aware auto-indent
- Sane default tab/space and tab width settings for tons of different languages
- (_Asynchronous!_) source code linting and autocomplete for a bunch of languages
- Remembers last location in a given file
- `~/.vim/backup` directory for holding `.swp` files, rather than littering them
  all over your filesystem
- Allows overrides in `~/.vimrc.local` for stuff you don't want to check in to
  source control

### helpful keybindings

- `ctrl-n` and `ctrl-m` for "bubbling" lines of text up and down, respectively,
  in normal, insert, and visual modes (via the _unimpaired_ plug-in)
- `ctrl-k` for deleting lines (i.e. `dd`)
- `F1` remapped to `:nohl` to turn off search highlighting
- `<leader>e` autocompletion to the current dir to edit a file
- `<leader>te` autocompletion to the current dir to edit a file in a new tab
- `ctrl-a` to jump to the beginning and `ctrl-e` to jump to the end of a line in
  command mode, just like in a shell
- `gp` to select the thing you just changed (or pasted) when in normal mode

[homebrew]: https://brew.sh
