{ self, inputs, config, pkgs, ... }:

{
  imports = [
    ../../modules/profiles/darwin-base.nix
    ../../modules/profiles/development.nix
    ../../modules/packages/darwin.nix
  ];
  
  # List packages installed in system profile
  environment.systemPackages = [];
  
  # Environment configuration
  environment.variables.PATH = "$PATH:$HOME/.local/bin";
  environment.systemPath = [ "$HOME/.local/bin" ];
  
  # Nix configuration
  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      substituters = [
        "https://nix-community.cachix.org"
        "https://cache.nixos.org/"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      ];
      trusted-users = [
        "root"
        "wheel"
        "rick"
      ];
    };
  };
  
  # Used for backwards compatibility
  system.stateVersion = 5;
  
  # Create /etc/zshrc that loads the nix-darwin environment
  programs.zsh.enable = true;
  
  # Fonts
  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.droid-sans-mono
    nerd-fonts.jetbrains-mono
  ];
  
  # macOS specific customizations
  system.activationScripts.postActivation.text = ''
    # disable spotlight
    launchctl unload -w /System/Library/LaunchDaemons/com.apple.metadata.mds.plist >/dev/null 2>&1 || true
    # disable fseventsd on /nix volume
    mkdir -p /nix/.fseventsd
    test -e /nix/.fseventsd/no_log || touch /nix/.fseventsd/no_log
  '';
  
  # System preferences
  system = {
    defaults = {
      NSGlobalDomain = {
        AppleMeasurementUnits = "Centimeters";
        AppleMetricUnits = 1;
        AppleShowAllExtensions = true;
        AppleTemperatureUnit = "Celsius";
        InitialKeyRepeat = 20;
        KeyRepeat = 2;
        ApplePressAndHoldEnabled = false;
      };
      dock = {
        autohide = true;
        show-recents = false;
        mru-spaces = false;
        tilesize = 32;
        minimize-to-application = true;
        orientation = "right";
        autohide-time-modifier = 0.0;
        expose-animation-duration = 0.0;
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
      };
      SoftwareUpdate.AutomaticallyInstallMacOSUpdates = true;
      NSGlobalDomain."com.apple.mouse.tapBehavior" = 1;
    };
  };
  
  # Keyboard configuration
  system.keyboard = {
    enableKeyMapping = true;
    remapCapsLockToEscape = true;
  };
  
  # Security - TouchID for sudo
  security.pam.enableSudoTouchIdAuth = true;
  
  # Home manager configuration
  home-manager.useGlobalPkgs = false;
  home-manager.useUserPackages = true;
  home-manager.users.rick = import ../../home/darwin.nix;
  home-manager.extraSpecialArgs = { inherit inputs; };
}