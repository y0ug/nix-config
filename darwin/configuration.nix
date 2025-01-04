{ config, pkgs, lib, ... }: {
  # Basic system configuration
  users.users.rick = {
    name = lib.user.name;
    home = "/Users/${lib.user.name}";
  };

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";

  # System-level packages
  environment.systemPackages = with pkgs; [
    vim
    git
  ];


  # System settings
  system = {
    defaults = {
      NSGlobalDomain = {
        AppleShowAllExtensions = true;
        InitialKeyRepeat = 15;
        KeyRepeat = 2;
      };
      dock = {
        autohide = true;
        show-recents = false;
        mru-spaces = false;
      };
      finder = {
        AppleShowAllExtensions = true;
        _FXShowPosixPathInTitle = true;
      };
    };
    # For nix-darwin
    stateVersion = 5;

    # Set Git commit hash for darwin-version.
    # configurationRevision = self.rev or self.dirtyRev or null;
  };

  # Keyboard
  system.keyboard = {
    enableKeyMapping = true;
    remapCapsLockToEscape = true;
  };

  # Enable nix-darwin features
  services.nix-daemon.enable = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Create /etc/zshrc that loads the nix-darwin environment
  programs.zsh.enable = true;

}
