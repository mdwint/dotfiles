{ pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../shared/system/base.nix
    ../shared/system/user.nix
  ];

  boot.loader.grub = {
    enable = true;
    zfsSupport = true;
    efiSupport = true;
    efiInstallAsRemovable = true;
    mirroredBoots = [
      { devices = [ "nodev" ]; path = "/boot"; }
    ];
  };
  boot.zfs.forceImportRoot = false;

  networking.hostId = "8425e349";
  networking.hostName = "mini";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Brussels";
  i18n.defaultLocale = "en_US.UTF-8";

  services.zfs.autoScrub.enable = true;

  services.openssh.enable = true;

  services.tailscale = {
    enable = true;
    permitCertUid = "caddy";
  };

  services.syncthing = {
    enable = true;
    openDefaultPorts = true;
    dataDir = "/srv/media/syncthing";
    overrideDevices = false;
    overrideFolders = false;
    guiPasswordFile = "/etc/syncthing-gui-password";
    settings.gui.user = "matteo";
  };

  services.jellyfin.enable = true;

  services.caddy = {
    enable = true;
    virtualHosts."sync.mini.home".extraConfig = ''
      reverse_proxy http://127.0.0.1:8384 {
          header_up Host "127.0.0.1"
      }
      tls internal
    '';
    virtualHosts."stream.mini.home".extraConfig = ''
      reverse_proxy http://127.0.0.1:8096
      tls internal
    '';
  };

  networking.firewall.allowedTCPPorts = [ 80 443 ];
  networking.firewall.allowedUDPPorts = [];

  system.stateVersion = "26.05";
}
