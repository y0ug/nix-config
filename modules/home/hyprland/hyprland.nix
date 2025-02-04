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
    # dolphin # kde
    #nautilus # gnome

    # like fuzzel dmenu
    wofi
    wofi-emoji

    mpv

    libsecret

    bitwarden-desktop
    bitwarden-cli

    # polkit
    hyprpolkitagent
    gcr

    seahorse
  ];

  # services.mpd-mpris.enable = true;
  # services.mpd.enable = true;
  services.playerctld.enable = true;

}
