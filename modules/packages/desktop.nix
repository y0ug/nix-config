{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Browsers
    firefox
    librewolf
    
    # File management
    nautilus
    yazi
    superfile
    
    # Document viewing
    evince
    
    # Media
    ffmpeg-full
    imv
    mpv
    
    # System utilities
    gparted
    killall
    libnotify
    bleachbit
    dust
    ncdu
    
    # Audio controls
    pamixer
    pavucontrol
    playerctl
    
    # Utilities
    xdg-utils
    wev
    powertop
    
    # Screenshot & recording
    flameshot
    hyprshot
    wl-screenrec
  ];
}