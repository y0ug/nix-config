{
  lib,
  ...
}:
{
  services.swaync = {
    enable = true;
    # style = ''
    #
    # '';
    settings = {
      positionX = "right";
      positionY = "top";
      control-center-height = 600;
      control-center-width = 500;
      fit-to-screen = false;
      control-center-margin-top = 5;
      control-center-margin-bottom = 5;
      control-center-margin-right = 5;
      control-center-margin-left = 5;
      hide-on-clear = true; # hide control center on clear
      #image-visibility = "when-available";
    };
  };

  services.mako.enable = lib.mkForce false;
  services.dunst.enable = lib.mkForce false;
}
