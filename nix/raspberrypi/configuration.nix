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

  services.transmission = {
    enable = true;
    openRPCPort = true;
    settings = {
      download-dir = "/mnt/red/Movies";
      incomplete-dir-enabled = false;
      rpc-host-whitelist = "transmission.home";
      rpc-url = "/";
    };
  };

  services.jellyfin = {
    enable = true;
    openFirewall = true;
    user = config.services.transmission.user;
  };

  services.caddy = {
    enable = true;
    virtualHosts."transmission.home".extraConfig = ''
      reverse_proxy http://127.0.0.1:9091
      tls internal
    '';
    virtualHosts."jellyfin.home".extraConfig = ''
      reverse_proxy http://127.0.0.1:8096
      tls internal
    '';
  };

  services.samba = {
    enable = true;
    openFirewall = true;
    settings = {
      global = {
        "security" = "user";
        "hosts allow" = "192.168.178.";
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

  services.unbound = {
    enable = true;
    settings = {
      server = let
        myIp = "192.168.178.100";
      in
      {
        interface = [ "127.0.0.1" myIp ];
        access-control = [ "192.168.178.0/24 allow" ];

        auto-trust-anchor-file = "/var/lib/unbound/root.key";

        harden-glue = true;
        harden-dnssec-stripped = true;
        use-caps-for-id = false;
        prefetch = true;
        edns-buffer-size = 1232;

        hide-identity = true;
        hide-version = true;

        local-zone = "\"home.\" static";
        local-data = [
          "\"jellyfin.home. A ${myIp}\""
          "\"transmission.home. A ${myIp}\""
        ];
      };

      forward-zone = [
        {
          name = ".";
          forward-addr = [
            "9.9.9.9#dns.quad9.net"
            "149.112.112.112#dns.quad9.net"
          ];
          forward-tls-upstream = true;
        }
      ];
    };
  };

  networking.firewall.allowedTCPPorts = [ 53 80 443 ];
  networking.firewall.allowedUDPPorts = [ 53 ];

  system.stateVersion = "25.11";
}
