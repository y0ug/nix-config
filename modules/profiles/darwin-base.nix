{ pkgs, ... }:

{
  imports = [
    ../packages/darwin.nix
  ];
  
  # System defaults
  system.defaults = {
    NSGlobalDomain = {
      AppleShowAllExtensions = true;
      InitialKeyRepeat = 20;
      KeyRepeat = 2;
    };
    dock = {
      autohide = true;
      show-recents = false;
    };
    finder = {
      AppleShowAllExtensions = true;
      FXEnableExtensionChangeWarning = false;
      ShowPathbar = true;
    };
  };
  
  # Common Darwin programs
  programs.zsh.enable = true;
  
  # Security and system settings
  security.pam.enableSudoTouchIdAuth = true;
  
  # Services specific to Darwin
  services.nix-daemon.enable = true;
}