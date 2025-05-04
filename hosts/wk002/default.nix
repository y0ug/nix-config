{ inputs, config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/profiles/base.nix
    ../../modules/profiles/desktop.nix
    ../../modules/profiles/development.nix
    ../../modules/profiles/hyprland.nix
  ];
  
  # Host-specific configuration
  networking.hostName = "wk002";
  
  # Boot configuration
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  
  # User configuration
  users.users.rick = {
    isNormalUser = true;
    description = "rick";
    extraGroups = [
      "networkmanager"
      "wheel"
      "video"
    ];
    shell = pkgs.zsh;
  };
  
  # Theming with Stylix
  stylix = {
    enable = true;
    autoEnable = true;
    polarity = "dark";
    base16Scheme = "${toString ../../modules/themes/stylix/arctic_vs_dark.yaml}";
    
    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Nerd Font";
      };
      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
    };
  };
  
  # Hardware configuration
  hardware.bluetooth.enable = true;
  
  system.stateVersion = "24.11";
}