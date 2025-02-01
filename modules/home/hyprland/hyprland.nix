{ inputs, pkgs, ... }: {
  home.packages = with pkgs; [
    hyprpicker
    hyprnotify
    hyprsunset
    hyprshot
    hyprcursor

    wl-clip-persist
    wf-recorder
    glib
  ];

 # systemd.user.targets.hyprland-session.Unit.Wants =
  #   [ "xdg-desktop-autostart.target" ];
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland = {
      enable = true;
      # hidpi = true;
    };
    # enableNvidiaPatches = false;
    systemd.enable = true;
  };

}
