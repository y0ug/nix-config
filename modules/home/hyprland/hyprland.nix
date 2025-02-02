{ inputs, pkgs, ... }:
{
  # deps
  home.packages = with pkgs; [
    hyprpicker
    hyprsunset
    hyprshot
    hyprcursor

    # notification
    # dunst
    swaynotificationcenter # swaync

    # fileManager
    nnn
    ranger
    yazi
    superfile

    cliphist
    wl-clipboard
    wl-clip-persist
    wl-clipboard

    wf-recorder
    wl-screenrec
    glib
    wlr-randr

    # filemanager
    dolphin

    # like fuzzel dmenu
    wofi

    # polkit
    hyprpolkitagent
  ];

}
