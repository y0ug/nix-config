{
  pkgs,
  lib,
  ...
}:
{
  home.packages = with pkgs; [
    # Niri and Wayland essentials
    niri
    xwayland-satellite

    # Screen locking
    swaylock
    swayidle

    # Wallpaper
    swaybg

    # Clipboard
    wl-clipboard
    cliphist

    # Screenshots
    slurp
    grim
    satty

    # Screen recording
    wl-screenrec

    # Notification
    libnotify
    mako

    # Launchers
    fuzzel
    rofi
    wofi

    # Utilities
    brightnessctl
    playerctl
    wlr-randr
    wayland-utils
    wev # wayland event viewer
  ];
}
