{ dotfile, ... }:
{
  imports = [ ../shared/home/base.nix ];

  home.username = "matteo";
  home.homeDirectory = "/home/matteo";

  xsession.enable = true;
  home.keyboard.options = [ "altwin:swap_alt_win" "caps:hyper" ];

  xdg.configFile = {
    "alacritty/alacritty.toml" = dotfile "alacritty/.config/alacritty/alacritty.nixos.toml";
    "ghostty/config" = dotfile "ghostty/.config/ghostty/config";
    "ghostty/config.local" = dotfile "ghostty/.config/ghostty/config.nixos";
    "fontconfig/conf.d/11-pragmatapro-mono-spacing.conf" =
      dotfile "fontconfig/.config/fontconfig/conf.d/11-pragmatapro-mono-spacing.conf";
  };

  home.stateVersion = "24.11";
}
