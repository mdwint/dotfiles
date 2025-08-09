{ pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../shared/system/base.nix
    ../shared/system/user.nix
  ];

  boot.loader.grub.enable = false;
  boot.loader.generic-extlinux-compatible.enable = true;

  networking.hostName = "raspberrypi";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Brussels";
  i18n.defaultLocale = "en_US.UTF-8";

  environment.systemPackages = with pkgs; [
  ];

  services.openssh.enable = true;

  system.stateVersion = "25.11";
}
