{ pkgs, ... }: {
  home.packages = [ pkgs.hyprlock ];
  # xdg.configFile."hypr/hyprlock.conf".text = ''
 
  # '';
}
