{ pkgs, dotfile, ... }:
{
  imports = [ ../shared/home/base.nix ];

  home.username = "matteo";
  home.homeDirectory = "/home/matteo";

  xsession.enable = true;
  home.keyboard.options = [ "altwin:swap_alt_win" "caps:hyper" ];

  xdg.configFile = {
    "alacritty/alacritty.toml" = dotfile "alacritty/.config/alacritty/alacritty.nixos.toml";
  };

  systemd.user.services.mount-icloud = {
    Unit = {
      Description = "Mount iCloud Drive with rclone";
      After = [ "network-online.target" ];
    };
    Service = {
      Type = "notify";
      Environment = "RCLONE_PASSWORD_COMMAND='kwallet-query -r rclone-icloud kdewallet'";
      ExecStartPre = "/usr/bin/env mkdir -p %h/iCloud";
      ExecStart = "${pkgs.rclone}/bin/rclone --vfs-cache-mode=writes mount icloud: %h/iCloud";
      ExecStop = "/usr/bin/env fusermount -u %h/iCloud";
      Restart = "on-failure";
      RestartSec = "10s";
    };
    Install.WantedBy = [ "default.target" ];
  };

  home.stateVersion = "24.11";
}
