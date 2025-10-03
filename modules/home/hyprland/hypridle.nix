{
  ...
}:
{
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        after_sleep_cmd = "hyprctl dispatch dpms on";
        before_sleep_cmd = "loginctl lock-session";
        lock_cmd = "hyprlock --grace 15";
      };

      listener = [
        {
          timeout = 120; # 2min
          on-timeout = "loginctl lock-session";
        }
        # Screen of
        {
          timeout = 300;
          on-timeout = "hyprctl dispatch dpms off"; # screen off
          on-resume = "hyprctl dispatch dpms on";
        }
      ];
    };
  };
}
