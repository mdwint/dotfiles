{ pkgs, ... }:
{
  imports = [
    ../shared/system/base.nix
    ../shared/system/user.nix
  ];

  programs.zsh.enable = true;

  homebrew = {
    enable = true;
    global.autoUpdate = false;
    onActivation.cleanup = "uninstall";

    taps = [
      "databricks/tap"
      "domt4/autoupdate"
    ];

    brews = [
      "databricks"
      "docker-credential-helper-ecr"
    ];

    casks = [
      "alacritty"
      "alfred"
      "balance-lock"
      "dash@6"
      # "emacs"
      # "font-iosevka"
      "gimp"
      "iina"
      "jordanbaird-ice"
      "karabiner-elements"
      "linearmouse"
      "monitorcontrol"
      "obsidian"
      "rectangle"
      "signal"
      "spotify"
      "ubersicht"
    ];
  };

  security.pam.services.sudo_local = {
    reattach = true;
    touchIdAuth = true;
  };

  system.defaults = {
    NSGlobalDomain = {
      ApplePressAndHoldEnabled = false;
      InitialKeyRepeat = 15;
      KeyRepeat = 2;
      _HIHideMenuBar = true;
    };

    dock = {
      autohide = true;
      launchanim = false;
      magnification = false;
      mineffect = "scale";
      minimize-to-application = true;
      orientation = "right";
      show-process-indicators = false;
      show-recents = false;
      static-only = true;
      tilesize = 64;
    };

    finder = {
      CreateDesktop = false;
      _FXShowPosixPathInTitle = true;
      _FXSortFoldersFirst = true;
    };
  };

  system.primaryUser = "matteo";
  system.stateVersion = 6;
}
