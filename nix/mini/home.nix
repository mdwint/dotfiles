{ ... }:
{
  imports = [ ../shared/home/base.nix ];

  home.username = "matteo";
  home.homeDirectory = "/home/matteo";

  home.stateVersion = "26.05";
}
