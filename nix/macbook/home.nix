{ dotfile, ... }:
{
  imports = [ ../shared/home/base.nix ];

  home.file = {
    ".zshrc" = dotfile "zsh/.zshrc";
    "Library/Application Support/Übersicht" = dotfile "ubersicht/Library/Application Support/Übersicht";
  };

  xdg.configFile = {
    "alacritty" = dotfile "alacritty/.config/alacritty";
  };

  home.stateVersion = "25.05";
}
