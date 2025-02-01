{ ... }: {
  imports = [
    ./fuzzel.nix # launcher
    # ./gtk.nix # gtk theme
    ./hyprland # window manager
    ./waybar # status bar
  ];
}
