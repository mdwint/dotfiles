#!/usr/bin/env sh
set -e

case "$(uname -a)" in
    Darwin*)        os=macos;;
    "Linux nixos"*) os=nixos;;
    Linux*)         os=linux;;
    *) echo "ERROR: Unsupported OS"; exit 1;;
esac

has() {
    [ -x "$(command -v "$1")" ]
}

if [ "$os" = macos ]; then
    xcode-select --install
fi

if [ ! -d ~/dotfiles ]; then
    clone='git clone https://github.com/mdwint/dotfiles.git ~/dotfiles'
    if [ "$os" = nixos ]; then
        nix-shell -p git --run "$clone"
    else
        $clone
    fi
fi
(
    cd ~/dotfiles

    if [ "$os" = macos ]; then
        if ! has nix; then
            curl -fsSL https://install.determinate.systems/nix | sh -s -- install
            . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
            sudo nix run nix-darwin/master#darwin-rebuild -- switch --flake .
        fi
        ./macos-defaults.sh
        stow -- */
        tic -x tmux/.tmux-terminfo.src
        brew autoupdate start 43200 --cleanup --immediate
    elif [ "$os" = nixos ]; then
        mkdir -p ~/.config/home-manager/
        ln -sf ~/dotfiles/flake.nix ~/.config/home-manager/
        sudo ln -sf ~/dotfiles/flake.nix /etc/nixos/
        [ -f /etc/nixos/hardware-configuration.nix ] &&
            cp /etc/nixos/hardware-configuration.nix ~/dotfiles/nixos/
        sudo nixos-rebuild switch
        home-manager switch
        sudo rm -f /etc/nixos/*configuration.nix
    elif has stow; then
        stow bin fish git neovim ripgrep tmux
    fi

    has nvim && nvim --headless '+Lazy! sync' +qa
)

if [ "$os" = macos ]; then
    has uv && while read -r pkg; do uv tool install "$pkg" || true; done <<'EOF'
s3-pit-restore
tox
twine
EOF
fi
