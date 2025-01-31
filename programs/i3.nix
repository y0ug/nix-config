{ config, pkgs, ... }:

lib.mkIf (config.programs.i3.enable) {
  home.packages = with pkgs; [
    i3status
    dmenu
    rofi 
    nitrogen
  ];

  programs.wezterm.enable = true;

  programs.i3 = {
    config = {
      modifier = "Mod4";
      keybindings = {
        "${modifier}+Return" = "exec ${pkgs.wezterm}/bin/wezterm";
        "${modifier}+d" = "exec ${pkgs.rofi}/bin/rofi -show drun";
      };
    };
  };
}
