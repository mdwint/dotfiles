#!/bin/sh
set -e

case "$(uname -s)" in
    Darwin*) os=macos;;
    Linux*)  os=linux;;
    *)       os=unknown;;
esac

has() {
    [ -x "$(command -v $1)" ]
}

if [ "$os" = macos ]; then
    has brew || ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    has git || brew install git
    has stow || brew install stow
fi

(
    target_dir=~/dotfiles
    [ -d "$target_dir" ] || git clone https://github.com/mdwint/dotfiles.git "$target_dir"
    cd "$target_dir"

    base16_shell=~/.config/base16-shell
    [ -d "$base16_shell" ] || git clone https://github.com/chriskempson/base16-shell.git "$base16_shell"

    if [ "$os" = macos ]; then
        stow */
        tic -x tmux/.tmux-terminfo.src
        brew bundle --no-lock --no-upgrade
    else
        stow base16 bin fish git neovim tmux
    fi

    if has nvim; then
        vim_plug="${XDG_DATA_HOME:-$HOME/.local/share}/nvim/site/autoload/plug.vim"
        [ -f "$vim_plug" ] || curl -fLo "$vim_plug" --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        nvim --headless +PlugInstall +qa
    fi
)

has rustup || curl https://sh.rustup.rs -sSf | sh
