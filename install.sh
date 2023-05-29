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
    has brew || bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    has git || brew install git
    has stow || brew install stow
fi

(
    target_dir=~/dotfiles
    [ -d "$target_dir" ] || git clone https://github.com/mdwint/dotfiles.git "$target_dir"
    cd "$target_dir"

    tpm=~/.tmux/plugins/tpm
    [ -d "$tpm" ] || git clone https://github.com/tmux-plugins/tpm "$tpm"

    base16_shell=~/.config/base16-shell
    [ -d "$base16_shell" ] || git clone https://github.com/chriskempson/base16-shell.git "$base16_shell"

    if [ "$os" = macos ]; then
        ./macos-defaults.sh
        stow */
        tic -x tmux/.tmux-terminfo.src
        brew bundle --no-lock --no-upgrade
    else
        stow base16 bin fish git neovim tmux
    fi

    if has nvim; then
        nvim --headless '+Lazy! sync' +qa
    fi

    has pipx && while read pkg; do pipx install $pkg || true; done <python-packages
)

has rustup || curl https://sh.rustup.rs -sSf | sh
