{ pkgs, ... }:
{
  nix.settings.experimental-features = "nix-command flakes";
  nixpkgs.config.allowUnfree = true;

  users.users.matteo = {
    description = "Matteo De Wint";
    home = "/Users/matteo";
    shell = pkgs.fish;
  };

  programs.zsh.enable = true;
  programs.fish.enable = true;

  environment.systemPackages = with pkgs; [
    awscli2
    colima
    coreutils
    difftastic
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
    go
    graphviz
    htop
    jdk17_headless
    lsd
    mosh
    neovim
    nodejs
    ollama
    parallel
    pgcli
    plantuml
    pyenv
    ripgrep
    ruff
    rustup
    terraform
    tig
    tmux
    tokei
    uv
    watch
    wget
    xxd
    yarn
    zig
    zlib
    zoxide
  ];

  homebrew = {
    enable = true;
    global.autoUpdate = false;
    onActivation.cleanup = "uninstall";

    taps = [
      "databricks/tap"
      "domt4/autoupdate"
    ];

    brews = [
      "databricks"
      "docker-credential-helper-ecr"
    ];

    casks = [
      "alacritty"
      "alfred"
      "balance-lock"
      "dash@6"
      # "emacs"
      # "font-iosevka"
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
  };

  system.defaults = {
    NSGlobalDomain = {
      ApplePressAndHoldEnabled = false;
      InitialKeyRepeat = 15;
      KeyRepeat = 2;
      _HIHideMenuBar = true;
    };

    dock = {
      autohide = true;
      launchanim = false;
      magnification = false;
      mineffect = "scale";
      minimize-to-application = true;
      orientation = "right";
      show-process-indicators = false;
      show-recents = false;
      static-only = true;
      tilesize = 64;
    };

    finder = {
      CreateDesktop = false;
      _FXShowPosixPathInTitle = true;
      _FXSortFoldersFirst = true;
    };
  };

  system.primaryUser = "matteo";
  system.stateVersion = 6;
}
