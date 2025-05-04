{ pkgs, ... }:

{
  home.packages = with pkgs; [
    vscodium
    glances
  ];
  
  homebrew = {
    enable = true;
    onActivation.cleanup = "zap";
    masApps = {
      "Microsoft Remote Desktop" = 1295203466;
      "Bitwarden" = 1352778147;
    };

    brews = [
      "bitwarden-cli"
    ];
    
    casks = [
      "orbstack"
      "keycastr"
      "linearmouse"
      "utm"
      "raycast"
      "firefox"
      "moonlight"
    ];
  };
}