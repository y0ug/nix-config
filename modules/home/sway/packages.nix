{
  pkgs,
  lib,
  ...
}:
{
  home.packages = with pkgs; [
    # Sway and Wayland essentials
    sway
    swaybg
    swaylock
    swayidle

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
    wev
  ];
}
