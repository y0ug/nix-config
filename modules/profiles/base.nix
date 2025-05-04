{ pkgs, ... }:

{
  imports = [
    ../packages/common.nix
  ];
  
  # Timezone and locale
  time.timeZone = "Europe/Paris";
  i18n.defaultLocale = "en_US.UTF-8";
  
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
        "https://devenv.cachix.org"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
      ];
      trusted-users = [
        "root"
        "wheel"
        "rick"
      ];
    };
  };
  
  # Enable common programs
  programs.zsh.enable = true;
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };
  
  # Security settings
  security.sudo.extraConfig = ''
    Defaults timestamp_timeout=120 # 2 hours timeout
    Defaults env_keep+=SSH_AUTH_SOCK
    Defaults env_keep+=EDITOR
  '';
  
  # Enable SSH server
  services.openssh.enable = true;
  
  # Common system settings
  environment.localBinInPath = true;
  programs.command-not-found.enable = false;
  programs.appimage.binfmt = true;
}