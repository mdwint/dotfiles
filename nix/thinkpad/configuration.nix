{ pkgs, lib, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../shared/system/base.nix
    ../shared/system/user.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "thinkpad";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Brussels";
  i18n.defaultLocale = "en_US.UTF-8";

  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;
  services.xserver.desktopManager.xfce.enable = true;

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  services.printing.enable = true;

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  # services.blueman.enable = true;

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # jack.enable = true;
    # media-session.enable = true;
  };

  services.tailscale.enable = true;

  services.avahi = {
    enable = true;
    nssmdns4 = true;
  };

  programs.firefox.enable = true;

  programs.thunar.plugins = with pkgs; [
    thunar-archive-plugin
    thunar-volman
  ];

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryPackage = lib.mkForce pkgs.pinentry-qt;
  };

  # services.openssh.enable = true;

  programs.kdeconnect.enable = true;

  system.stateVersion = "24.11";
}
