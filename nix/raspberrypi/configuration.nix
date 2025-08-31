{ pkgs, lib, config, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../shared/system/base.nix
    ../shared/system/user.nix
  ];

  boot.kernelPackages = pkgs.linuxKernel.packages.linux_rpi4;
  boot.initrd.availableKernelModules = [ "usb_storage" ];
  boot.loader.grub.enable = false;
  boot.loader.generic-extlinux-compatible.enable = true;

  networking.hostName = "raspberrypi";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Brussels";
  i18n.defaultLocale = "en_US.UTF-8";

  fileSystems = {
    "/" = lib.mkForce {
      device = "/dev/disk/by-label/NIXOS_SD";
      fsType = "ext4";
      options = [ "noatime" ];
    };

    "/mnt/blue" = {
      device = "/dev/disk/by-label/Blue";
      fsType = "ext4";
      options = [ "noatime" "nofail" "x-systemd.device-timeout=10" ];
    };

    "/mnt/red" = {
      device = "/dev/disk/by-label/Red";
      fsType = "ext4";
      options = [ "noatime" "nofail" "x-systemd.device-timeout=10" ];
    };
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

  services.transmission = {
    enable = true;
    openRPCPort = true;
    settings = {
      download-dir = "/mnt/red/Movies";
      incomplete-dir-enabled = false;
      rpc-host-whitelist = "transmission.home";
    };
  };

  services.jellyfin = {
    enable = true;
    user = config.services.transmission.user;
  };

  services.miniflux = {
    enable = true;
    config = {
      LISTEN_ADDR = "localhost:8027";
      BASE_URL = "https://rss.home";
    };
    adminCredentialsFile = "/etc/miniflux-admin-credentials";
  };

  services.nextcloud = {
    enable = true;
    hostName = "localhost";
    config = {
      dbtype = "sqlite";
      adminpassFile = "/etc/nextcloud-admin-pass";
    };
    caching.redis = true;
    settings = {
      trusted_domains = [ "files.home" ];
      trusted_proxies = [ "127.0.0.1" ];
      overwriteprotocol = "https";
    };
  };

  services.nginx = {
    virtualHosts."localhost" = {
      listen = [ { addr = "127.0.0.1"; port = 8080; } ];
      forceSSL = false;
      enableACME = false;
    };
  };

  services.caddy = {
    enable = true;
    virtualHosts."files.home".extraConfig = ''
      reverse_proxy http://127.0.0.1:8080
      tls internal
    '';
    virtualHosts."jellyfin.home".extraConfig = ''
      reverse_proxy http://127.0.0.1:8096
      tls internal
    '';
    virtualHosts."rss.home".extraConfig = ''
      reverse_proxy http://127.0.0.1:8027
      tls internal
    '';
    virtualHosts."transmission.home".extraConfig = ''
      reverse_proxy http://127.0.0.1:9091
      tls internal
    '';
  };

  services.samba = {
    enable = true;
    openFirewall = true;
    settings = {
      global = {
        "security" = "user";
        "hosts allow" = "100. 192.168.178.";
        "hosts deny" = "0.0.0.0/0";
        "guest account" = "nobody";
        "map to guest" = "bad user";
        "fruit:copyfile" = "yes";
      };
      mnt = {
        "path" = "/mnt";
        "read only" = "yes";
        "guest ok" = "yes";
      };
    };
  };

  networking.firewall.allowedTCPPorts = [ 80 443 ];
  networking.firewall.allowedUDPPorts = [];

  system.stateVersion = "25.11";
}
