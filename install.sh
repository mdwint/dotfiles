#!/bin/sh
set -e

exists() {
    [ -x "$(command -v $1)" ]
}

exists brew || ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
exists git || brew install git

(
    TARGET_DIR=~/dotfiles
    git clone git@github.com:mdwint/dotfiles.git "$TARGET_DIR"
    cd "$TARGET_DIR"

    brew bundle
    stow */
)

exists rustup || curl https://sh.rustup.rs -sSf | sh
