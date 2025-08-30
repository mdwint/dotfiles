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
      rpc-host-whitelist = "raspberrypi.local,raspberrypi.prawn-vibe.ts.net";
    };
  };

  services.jellyfin = {
    enable = true;
    openFirewall = true;
    user = config.services.transmission.user;
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
      trusted_domains = [ "raspberrypi.prawn-vibe.ts.net" ];
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
    virtualHosts."raspberrypi.local".extraConfig = ''
      reverse_proxy /transmission/* http://127.0.0.1:9091
      reverse_proxy http://127.0.0.1:8096
      tls internal
    '';
    virtualHosts."raspberrypi.prawn-vibe.ts.net".extraConfig = ''
      reverse_proxy /transmission/* http://127.0.0.1:9091
      reverse_proxy http://127.0.0.1:8080
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

  services.avahi = {
    enable = true;
    openFirewall = true;
    nssmdns4 = true;
    publish = {
      enable = true;
      addresses = true;
    };
  };

  services.unbound = {
    enable = true;
    settings = {
      server = {
        interface = [ "127.0.0.1" "192.168.178.100" ];
        access-control = [ "192.168.178.0/24 allow" ];

        auto-trust-anchor-file = "/var/lib/unbound/root.key";

        harden-glue = true;
        harden-dnssec-stripped = true;
        use-caps-for-id = false;
        prefetch = true;
        edns-buffer-size = 1232;

        hide-identity = true;
        hide-version = true;
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
