{ ... }: {
  imports = [
    ./fuzzel.nix # launcher
    ./gtk.nix # gtk theme
    ./hyprland # window manager
    ./swaync/swaync.nix # notification deamon
    ./swaylock.nix # lock screen
    ./waybar # status bar
  ];
}
