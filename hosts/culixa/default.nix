{ inputs, config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/profiles/base.nix
    ../../modules/profiles/desktop.nix
    ../../modules/profiles/development.nix
    ../../modules/profiles/hyprland.nix
    ../../modules/profiles/virtualization.nix
  ];

  # Host-specific configuration
  networking.hostName = "culixa";
  networking.hostId = "95166fcd";
  
  # Hardware settings
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = [ "zfs" ];
  boot.extraModprobeConfig = "options kvm_intel nested=1";
  
  # Intel-specific graphics
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      vpl-gpu-rt
      intel-media-driver
      intel-compute-runtime
      libvdpau-va-gl
    ];
  };
  
  # System user configuration
  users.users.rick = {
    isNormalUser = true;
    description = "rick";
    extraGroups = [
      "docker"
      "networkmanager"
      "wheel"
      "plugdev"
      "video"
      "render"
    ];
    shell = pkgs.zsh;
  };
  
  # Additional services
  services.sunshine = {
    enable = true;
    autoStart = true;
    capSysAdmin = true;
    openFirewall = true;
  };
  
  # Firewall configuration
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [
      22
      47984
      47989
      47990
      48010
    ];
    allowedUDPPortRanges = [
      { from = 47998; to = 48000; }
      { from = 8000; to = 8010; }
    ];
  };
  
  # Theming with Stylix
  stylix = {
    enable = true;
    autoEnable = true;
    polarity = "dark";
    base16Scheme = "${toString ../../modules/themes/stylix/arctic_vs_dark.yaml}";
    opacity = {
      terminal = 1.0;
      popups = 1.0;
    };
    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 24;
    };
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
  
  # Hardware interfaces 
  hardware.keyboard.qmk.enable = true;
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  
  system.stateVersion = "24.11";
}