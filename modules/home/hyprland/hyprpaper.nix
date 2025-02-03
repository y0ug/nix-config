{
  ...
}:
{
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      splash = false;
      splash_offset = 2.0;
      preload = "$HOME/.local/state/wallpapers/default.jpg";
      wallpaper = ",$HOME/.local/state/wallpapers/default.jpg";
    };
  };
}
