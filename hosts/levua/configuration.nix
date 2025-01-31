{ self, config, pkgs, ... }: {
  import [
    ../programs/aerospace.nix
  ]
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = [ ];

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

  system.activationScripts.postActivation.text = ''
    # disable spotlight
    launchctl unload -w /System/Library/LaunchDaemons/com.apple.metadata.mds.plist >/dev/null 2>&1 || true
    # disable fseventsd on /nix volume
    mkdir -p /nix/.fseventsd
    test -e /nix/.fseventsd/no_log || touch /nix/.fseventsd/no_log
  '';

  system = {
    defaults = {
      NSGlobalDomain = {
        AppleMeasurementUnits = "Centimeters";
        AppleMetricUnits = 1;
        AppleShowAllExtensions = true;
        AppleTemperatureUnit = "Celsius";
        InitialKeyRepeat = 20;
        KeyRepeat = 2;
      };
      dock = {
        autohide = true;
        show-recents = false;
        mru-spaces = false;
        tilesize = 32;
        minimize-to-application = true;
        persistent-apps = [
          "/Applications/Safari.app"
          "${pkgs.wezterm}/Applications/Wezterm.app/"
        ];
        persistent-others = [ ];
        autohide-time-modifier = 0.0;
        expose-animation-duration = 0.0;
        orientation = "right";
      };
      finder = {
        AppleShowAllExtensions = true;
        FXDefaultSearchScope = "SCcf";
        FXEnableExtensionChangeWarning = false;
        FXPreferredViewStyle = "Nlsv";
        ShowPathbar = true;
      };
      trackpad = {
        Clicking = true;
        Dragging = true;
        # swapLeftCommandAndLeftAlt = true;
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
    masApps = {
      # "Xcode" = 497799835;
      "Microsoft Remote Desktop" = 1295203466;
      "Bitwarden" = 1352778147;
    };

    brews = [

      "bitwarden-cli"
    ];
    casks = [
      # "bitwarden"
      # "docker"
      "orbstack"
      "keycastr"
      "linearmouse"
      "utm"
      "raycast"
      "firefox"
    ];
  };
}
