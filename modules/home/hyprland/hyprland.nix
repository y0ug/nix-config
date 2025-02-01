{ inputs, pkgs, ... }:
{
  home.packages = with pkgs; [
    hyprpicker
    hyprsunset
    hyprshot
    hyprcursor

    # wallpaper
    hyprpaper
    #wpaperd # if we want dynamic

    # notification
    dunst
    swaynotificationcenter # swaync

    # fileManager
    nnn
    ranger
    yazi

    cliphist
    wl-clipboard
    wl-clip-persist

    wf-recorder
    glib

    # filemanager
    wofi
    dolphin
  ];

  # systemd.user.targets.hyprland-session.Unit.Wants =
  #   [ "xdg-desktop-autostart.target" ];
  # wayland.windowManager.hyprland.enable = false;
  # = {
  #   enable = true;
  #   xwayland = {
  #     enable = true;
  #     # hidpi = true;
  #   };
  #   # enableNvidiaPatches = false;
  #   systemd.enable = true;
  # };

}
