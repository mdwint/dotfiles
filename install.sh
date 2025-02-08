#!/usr/bin/env sh
set -e

case "$(uname -s)" in
    Darwin*) os=macos;;
    Linux*)  os=linux;;
    *)       os=unknown;;
esac

has() {
    [ -x "$(command -v "$1")" ]
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

    if [ "$os" = macos ]; then
        ./macos-defaults.sh
        stow -- */
        tic -x tmux/.tmux-terminfo.src
        brew bundle --no-lock --no-upgrade
        brew autoupdate start 43200 --cleanup --immediate
    else
        stow bin fish git neovim ripgrep tmux
    fi

    has nvim && nvim --headless '+Lazy! sync' +qa
    has pipx && while read -r pkg; do pipx install "$pkg" || true; done <python-packages
)

has rustup || curl https://sh.rustup.rs -sSf | sh
