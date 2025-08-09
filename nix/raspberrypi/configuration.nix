{ pkgs, lib, ... }:
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

  system.stateVersion = "25.11";
}
