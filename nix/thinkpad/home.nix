{ lib, pkgs, config, ... }:
let
  dotfile = path: {
    source = config.lib.file.mkOutOfStoreSymlink
      "${config.home.homeDirectory}/dotfiles/${path}";
  };
in
{
  home.username = "matteo";
  home.homeDirectory = "/home/matteo";

  home.packages = with pkgs; [
    alacritty
    aws-vault
    awscli2
    cargo
    cmake
    emacs30
    fd
    fish
    fzf
    git
    go
    jdk
    kdePackages.dragon
    libtool
    lsd
    neovim
    nodejs
    python3
    rclone
    ripgrep
    rustc
    signal-desktop
    spotify
    tmux
    uv
    xxd
    zig
    zoxide
  ];

  xsession.enable = true;
  home.keyboard.options = [ "altwin:swap_alt_win" "caps:hyper" ];

  home.file = {
    ".gitconfig" = dotfile "git/.gitconfig";
    ".ripgreprc" = dotfile "ripgrep/.ripgreprc";
    "bin" = dotfile "bin/bin";
  };

  xdg.configFile = {
    "alacritty/alacritty.toml" = dotfile "alacritty/.config/alacritty/alacritty.nixos.toml";
    "emacs" = dotfile "emacs/.config/emacs";
    "fish" = dotfile "fish/.config/fish";
    "nvim" = dotfile "neovim/.config/nvim";
    "ruff" = dotfile "ruff/.config/ruff";
    "tmux" = dotfile "tmux/.config/tmux";
  };

  systemd.user.services.mount-icloud = {
    Unit = {
      Description = "Mount iCloud Drive with rclone";
      After = [ "network-online.target" ];
    };
    Service = {
      Type = "notify";
      Environment = "RCLONE_PASSWORD_COMMAND='kwallet-query -r rclone-icloud kdewallet'";
      ExecStartPre = "/usr/bin/env mkdir -p %h/iCloud";
      ExecStart = "${pkgs.rclone}/bin/rclone --vfs-cache-mode=writes mount icloud: %h/iCloud";
      ExecStop = "/usr/bin/env fusermount -u %h/iCloud";
      Restart = "on-failure";
      RestartSec = "10s";
    };
    Install.WantedBy = [ "default.target" ];
  };

  programs.home-manager.enable = true;

  home.stateVersion = "24.11";
}
