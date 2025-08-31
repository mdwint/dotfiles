{ pkgs, ... }:
let
  common = with pkgs; [
    awscli2
    entr
    fd
    fish
    fzf
    git
    git-filter-repo
    git-lfs
    go
    htop
    lsd
    mosh
    neovim
    nodejs
    ripgrep
    rustup
    tmux
    uv
    xxd
    zig
    zoxide
  ];

  darwin = with pkgs; [
    colima
    coreutils
    difftastic
    docker
    docker-buildx
    docker-compose
    fnm
    graphviz
    jdk17_headless
    ollama
    parallel
    pgcli
    plantuml
    pyenv
    ruff
    terraform
    tokei
    watch
    wget
    yarn
    zlib
  ];

  linux = with pkgs; [
    alacritty
    aws-vault
    cmake
    emacs30
    gcc
    gnumake
    jdk
    kdePackages.dragon
    libtool
    nextcloud-client
    python3
    rclone
    signal-desktop
    unzip
    zip
  ];
in
{
  all = common ++ (if pkgs.stdenv.isDarwin then darwin else linux);
}
