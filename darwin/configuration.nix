{ self, config, pkgs, lib, ... }: {
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages =
    [ pkgs.vim
    ];

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  # Enable alternative shell support in nix-darwin.
  # programs.fish.enable = true;

  # Set Git commit hash for darwin-version.
  system.configurationRevision = self.rev or self.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 5;


  # System-level packages
  environment.systemPackages = with pkgs; [
    vim
    git
  ];


  # System settings
  system = {
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
