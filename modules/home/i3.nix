{ config, pkgs, ... }:

{
  imports = [./wezterm.nix];

  home.packages = with pkgs; [
    i3status
    dmenu
    rofi 
    nitrogen
  ];

  xsession.windowManager.i3 = {
    enable = true;
    package = pkgs.i3-gaps;
    config = {
      modifier = "Mod4";
      gaps = {
        inner = 10;
        outer = 5;
      };
      keybindings = {
        "\${modifier}+Return" = "exec ${pkgs.wezterm}/bin/wezterm";
        "\${modifier}+d" = "exec ${pkgs.rofi}/bin/rofi -show drun";
      };
    };
  };
}
