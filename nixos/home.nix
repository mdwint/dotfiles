{ lib, pkgs, config, ... }:
{
  home = {
    packages = with pkgs; [
      alacritty
      cargo
      fish
      fzf
      git
      go
      lsd
      neovim
      nodejs
      python3
      ripgrep
      rustc
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

  programs.home-manager.enable = true;
}
