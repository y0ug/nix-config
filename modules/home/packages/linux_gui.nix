{ pkgs, inputs, ... }:
{
  home.packages = with pkgs; ([
    librewolf
    freerdp3
    imv # image viewer
    gparted # partition editor

    # obsidian # markdown editor unfree

    libnotify
    bleachbit # disk cleaner

    libnotify
    pamixer
    pavucontrol
    qpwgraph
    playerctl

    xdg-utils
    wev # to find keycode
    powertop

  ]);

}
