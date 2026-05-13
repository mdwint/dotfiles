{ pkgs, lib, config, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../shared/system/base.nix
    ../shared/system/user.nix
  ];

  boot.initrd.availableKernelModules = [ "usb_storage" ];
  boot.loader.grub.enable = false;
  boot.loader.generic-extlinux-compatible.enable = true;

  networking.hostName = "raspberrypi";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Brussels";
  i18n.defaultLocale = "en_US.UTF-8";

  fileSystems = {
    "/".options         = [ "noatime" ];
    "/mnt/blue".options = [ "noatime" "nofail" "x-systemd.device-timeout=10" ];
    "/mnt/red".options  = [ "noatime" "nofail" "x-systemd.device-timeout=10" ];
  };

  systemd.tmpfiles.rules = [
    "d /mnt/blue 0755 root root -"
    "d /mnt/red  0755 root root -"
  ];

  services.openssh.enable = true;

  services.tailscale = {
    enable = true;
    permitCertUid = "caddy";
  };

  services.syncthing = {
    enable = true;
    openDefaultPorts = true;
    dataDir = "/mnt/blue/syncthing";
    overrideDevices = false;
    overrideFolders = false;
    guiPasswordFile = "/etc/syncthing-gui-password";
    settings.gui.user = "matteo";
  };

  services.caddy = {
    enable = true;
    virtualHosts."sync.pi.home".extraConfig = ''
      reverse_proxy http://127.0.0.1:8384 {
          header_up Host "127.0.0.1"
      }
      bind 100.92.40.13
      tls internal
    '';
  };

  networking.firewall.allowedTCPPorts = [ 80 443 ];
  networking.firewall.allowedUDPPorts = [];

  system.stateVersion = "25.11";
}
