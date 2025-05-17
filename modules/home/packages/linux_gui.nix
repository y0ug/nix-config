{ pkgs, inputs, ... }:
{
  home.packages = with pkgs; ([
    librewolf
    freerdp3

    imv # image viewer
    mpd # media player
    imv # video player

    playerctl # control media players

    # gparted # partition editor

    # obsidian # markdown editor unfree

    # bleachbit # disk cleaner

    pamixer # pulse audio cli tools
    pavucontrol # pulse audio volume control
    qpwgraph # graphical patchbay for pipewire

    xdg-utils
    wev # to find keycode
    powertop
  ]);

}
