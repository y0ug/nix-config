{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Hyprland-specific
    hyprpicker
    hyprsunset
    hyprshot
    hyprcursor
    hyprpolkitagent
    
    # Clipboard management
    cliphist
    wl-clipboard
    wl-clip-persist
    
    # Screen recording/capture
    wf-recorder
    wl-screenrec
    slurp
    glib
    wlr-randr
    
    # Application launchers
    wofi
    wofi-emoji
    
    # System integration
    libsecret
    gcr
    seahorse
    tridactyl-native
  ];
}