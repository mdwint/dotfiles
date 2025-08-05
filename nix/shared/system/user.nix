{ pkgs, ... }:
let
  isDarwin = pkgs.stdenv.isDarwin;
in
{
  users.users.matteo = {
    description = "Matteo De Wint";
    home = if isDarwin then "/Users/matteo" else "/home/matteo";
    shell = pkgs.fish;
  } // (if isDarwin then {} else {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" ];
  });
}
