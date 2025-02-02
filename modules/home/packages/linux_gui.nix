{ pkgs, inputs, ... }:
{
  home.packages = with pkgs; ([
    firefox
    freerdp3
    evince # pdf viewier
    imv # image viewer
    gparted # partition editor

    obsidian # markdown editor unfree

    man-pages # extra man pages
    killall
    libnotify
    bleachbit # disk cleaner
    dust # disk usage analyzer

    yazi # terminal file manager
    superfile # SPF file manager to be test

    libnotify
    ncdu # disk space
    pamixer
    pavucontrol
    playerctl

    xdg-utils

  ]);

}
