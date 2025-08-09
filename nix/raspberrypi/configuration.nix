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

  environment.systemPackages = with pkgs; [
  ];

  services.openssh.enable = true;

  services.transmission = {
    enable = true;
    openRPCPort = true;
    settings = {
      download-dir = "/mnt/red/Movies";
      incomplete-dir-enabled = false;
      rpc-bind-address = "0.0.0.0";
      rpc-host-whitelist = config.networking.hostName;
      rpc-whitelist = "192.168.178.*,100.*.*.*";
    };
  };

  services.jellyfin = {
    enable = true;
    openFirewall = true;
    user = config.services.transmission.user;
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

  system.stateVersion = "25.11";
}
