{ self, config, pkgs, ... }: {
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = [ pkgs.vim ];

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 5;

  # Create /etc/zshrc that loads the nix-darwin environment
  programs.zsh.enable = true;

  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.droid-sans-mono
    nerd-fonts.jetbrains-mono
  ];

  system = {
    defaults = {
      NSGlobalDomain = {
        AppleShowAllExtensions = true;
        InitialKeyRepeat = null;
        KeyRepeat = null;
      };
      dock = {
        autohide = true;
        show-recents = false;
        mru-spaces = false;
        tilesize = 32;
        persistent-apps = [
          "/Applications/Safari.app"
          "/System/Applications/Utilities/Terminal.app"
          "${pkgs.wezterm}/Applications/Wezterm.app/"
        ];
        persistent-others = [ ];
        autohide-time-modifier = 0.0;
        expose-animation-duration = 0.0;
        orientation = "right";
      };
      finder = {
        AppleShowAllExtensions = true;
        _FXShowPosixPathInTitle = true;
        CreateDesktop = false;
      };
      trackpad = {
        Clicking = true;
        Dragging = true;
      };
      SoftwareUpdate.AutomaticallyInstallMacOSUpdates = true;
      NSGlobalDomain."com.apple.mouse.tapBehavior" = 1;
    };
  };

  system.keyboard = {
    enableKeyMapping = true;
    remapCapsLockToEscape = true;
  };

  # sudo touch id
  security.pam.enableSudoTouchIdAuth = true;

  # Disable press and hold for diacritics.
  # I want to be able to press and hold j and k
  # in VSCode with vim keys to move around.
  system.defaults.NSGlobalDomain.ApplePressAndHoldEnabled = false;

  homebrew = {
    enable = true;
    onActivation.cleanup = "zap";

    casks = [ "bitwarden" "docker" "keycastr" "linearmouse" "utm" ];
  };
}
