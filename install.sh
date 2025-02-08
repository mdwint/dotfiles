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
    [ -d ~/dotfiles ] || git clone https://github.com/mdwint/dotfiles.git ~/dotfiles
    cd ~/dotfiles

    if [ "$os" = macos ]; then
        ./macos-defaults.sh
        stow -- */
        tic -x tmux/.tmux-terminfo.src
        brew bundle --no-lock --no-upgrade
        brew autoupdate start 43200 --cleanup --immediate
        has rustup || curl https://sh.rustup.rs -sSf | sh
    elif has stow; then
        stow bin fish git neovim ripgrep tmux
    fi

    has nvim && nvim --headless '+Lazy! sync' +qa
)

if [ "$os" = macos ]; then
    has uv || curl -LsSf https://astral.sh/uv/install.sh | sh
    has uv && while read -r pkg; do uv tool install "$pkg" || true; done <<'EOF'
        aws-export-credentials
        s3-pit-restore
        tox
        twine
    EOF
endif
