{ self, config, pkgs, ... }: {
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages =
    [ pkgs.vim
    ];

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
        InitialKeyRepeat = 15;
        KeyRepeat = 2;
      };
      dock = {
        autohide = true;
        show-recents = false;
        mru-spaces = false;
        persistent-apps = [ "/Applications/Safari.app", "/System/Applications/Utilities/Terminal.app" ];
      };
      finder = {
        AppleShowAllExtensions = true;
        _FXShowPosixPathInTitle = true;
      };
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

}
