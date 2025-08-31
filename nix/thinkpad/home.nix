{ dotfile, ... }:
{
  imports = [ ../shared/home/base.nix ];

  home.username = "matteo";
  home.homeDirectory = "/home/matteo";

  xsession.enable = true;
  home.keyboard.options = [ "altwin:swap_alt_win" "caps:hyper" ];

  xdg.configFile = {
    "alacritty/alacritty.toml" = dotfile "alacritty/.config/alacritty/alacritty.nixos.toml";
  };

  home.stateVersion = "24.11";
}
