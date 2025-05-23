{ inputs, pkgs, ... }:
{
  # deps
  home.packages = with pkgs; [
    hyprpicker
    hyprsunset
    hyprshot
    hyprcursor

    # fileManager
    nnn
    ranger
    yazi
    superfile

    cliphist
    wl-clipboard
    wl-clip-persist

    wf-recorder
    wl-screenrec
    slurp # find windows position and sixe
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

    # bitwarden-desktop
    # bitwarden-cli

    # polkit
    hyprpolkitagent
    gcr

    seahorse
    tridactyl-native
  ];

  # services.mpd-mpris.enable = true;
  # services.mpd.enable = true;
  services.playerctld.enable = true;

}
