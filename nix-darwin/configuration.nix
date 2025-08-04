{ pkgs, ... }:
{
  nixpkgs.hostPlatform = "aarch64-darwin";
  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = "nix-command flakes";

  users.users.matteo = {
    description = "Matteo De Wint";
    shell = pkgs.fish;
  };

  programs.zsh.enable = true;
  programs.fish.enable = true;

  environment.systemPackages = with pkgs; [
    awscli2
    colima
    coreutils
    databricks-cli
    direnv
    docker
    docker-buildx
    docker-compose
    entr
    fd
    fnm
    fzf
    git
    git-filter-repo
    git-lfs
    graphviz
    htop
    jdk24_headless
    lsd
    mosh
    neovim
    ollama
    parallel
    plantuml
    pyenv
    ripgrep
    rustup
    stow
    terraform
    tig
    tmux
    tokei
    uv
    watch
    wget
    xxd
    yarn
    zlib
    zoxide
  ];

  homebrew = {
    enable = true;
    global.autoUpdate = false;
    onActivation.cleanup = "uninstall";

    taps = [
      "domt4/autoupdate"
    ];

    brews = [
      "docker-credential-helper-ecr"
    ];

    casks = [
      "alacritty"
      "alfred"
      "balance-lock"
      "dash@6"
      # "emacs"
      "font-iosevka"
      "gimp"
      "iina"
      "jordanbaird-ice"
      "karabiner-elements"
      "linearmouse"
      "monitorcontrol"
      "obsidian"
      "rectangle"
      "signal"
      "spotify"
      "ubersicht"
    ];
  };

  security.pam.services.sudo_local = {
    reattach = true;
    touchIdAuth = true;
    watchIdAuth = true;
  };

  system.primaryUser = "matteo";
  system.stateVersion = 6;
}
