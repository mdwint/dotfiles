{ lib, pkgs, config, ... }:
{
  home = {
    packages = with pkgs; [
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

    username = "matteo";
    homeDirectory = "/home/matteo";

    stateVersion = "24.11";
  };

  xsession.enable = true;
  home.keyboard.options = [ "altwin:swap_alt_win" "caps:hyper" ];

  home.file = {
    "bin" = {
      source = config.lib.file.mkOutOfStoreSymlink
        "${config.home.homeDirectory}/dotfiles/bin/bin";
      recursive = true;
    };

    ".gitconfig" = {
      source = config.lib.file.mkOutOfStoreSymlink
        "${config.home.homeDirectory}/dotfiles/git/.gitconfig";
      recursive = true;
    };

    ".ripgreprc" = {
      source = config.lib.file.mkOutOfStoreSymlink
        "${config.home.homeDirectory}/dotfiles/ripgrep/.ripgreprc";
    };
  };

  xdg.configFile = {
    "alacritty/alacritty.toml" = {
      source = config.lib.file.mkOutOfStoreSymlink
        "${config.home.homeDirectory}/dotfiles/alacritty/.config/alacritty/alacritty.nixos.toml";
    };

    "emacs" = {
      source = config.lib.file.mkOutOfStoreSymlink
        "${config.home.homeDirectory}/dotfiles/emacs/.config/emacs";
      recursive = true;
    };

    "fish" = {
      source = config.lib.file.mkOutOfStoreSymlink
        "${config.home.homeDirectory}/dotfiles/fish/.config/fish";
      recursive = true;
    };

    "nvim" = {
      source = config.lib.file.mkOutOfStoreSymlink
        "${config.home.homeDirectory}/dotfiles/neovim/.config/nvim";
      recursive = true;
    };

    "tmux" = {
      source = config.lib.file.mkOutOfStoreSymlink
        "${config.home.homeDirectory}/dotfiles/tmux/.config/tmux";
      recursive = true;
    };
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
}
