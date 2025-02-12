{
  lib,
  ...
}:
{
  services.swaync = {
    enable = true;
    style = ''
          * {
          font-family: "JetBrains Mono Nerd Font";
          font-weight: bold;
      }
    '';
    # settings = {
    #   positionX = "right";
    #   positionY = "top";
    #   control-center-height = 600;
    #   control-center-width = 500;
    #   fit-to-screen = false;
    #   control-center-margin-top = 5;
    #   control-center-margin-bottom = 5;
    #   control-center-margin-right = 5;
    #   control-center-margin-left = 5;
    #   hide-on-clear = true; # hide control center on clear
    #   #image-visibility = "when-available";
    # };
    settings = builtins.fromJSON (builtins.readFile ./config.json);
  };
  # home.file.".config/swaync/config.json".text = builtins.readFile ./config.json;
  services.mako.enable = lib.mkForce false;
  services.dunst.enable = lib.mkForce false;
}
