{ lib, pkgs, config, ... }:
let
  dotfile = path: {
    source = config.lib.file.mkOutOfStoreSymlink
      "${config.home.homeDirectory}/dotfiles/${path}";
  };
in
{
  home.file = {
    ".gitconfig" = dotfile "git/.gitconfig";
    ".ripgreprc" = dotfile "ripgrep/.ripgreprc";
    ".zshrc" = dotfile "zsh/.zshrc";
    "Library/Application Support/Übersicht" = dotfile "ubersicht/Library/Application Support/Übersicht";
    "bin" = dotfile "bin/bin";
  };

  xdg.configFile = {
    "alacritty" = dotfile "alacritty/.config/alacritty";
    "emacs" = dotfile "emacs/.config/emacs";
    "fish" = dotfile "fish/.config/fish";
    "nvim" = dotfile "neovim/.config/nvim";
    "ruff" = dotfile "ruff/.config/ruff";
    "tmux" = dotfile "tmux/.config/tmux";
  };

  home.stateVersion = "25.05";
}
