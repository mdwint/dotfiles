{ pkgs, config, ... }:
let
  dotfile = path: {
    source = config.lib.file.mkOutOfStoreSymlink
      "${config.home.homeDirectory}/dotfiles/${path}";
  };
in
{
  _module.args.dotfile = dotfile;

  home.packages = (import ../packages.nix { inherit pkgs; }).all;

  home.file = {
    ".gitconfig" = dotfile "git/.gitconfig";
    ".ripgreprc" = dotfile "ripgrep/.ripgreprc";
    "bin" = dotfile "bin/bin";
  };

  xdg.configFile = {
    "emacs" = dotfile "emacs/.config/emacs";
    "fish" = dotfile "fish/.config/fish";
    "nvim" = dotfile "neovim/.config/nvim";
    "ruff" = dotfile "ruff/.config/ruff";
    "tmux" = dotfile "tmux/.config/tmux";
  };

  programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}
