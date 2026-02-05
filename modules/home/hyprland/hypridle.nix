{
  lib,
  ...
}:
{
  # Only start hypridle when HYPRLAND_INSTANCE_SIGNATURE is set (i.e., in Hyprland)
  systemd.user.services.hypridle.Unit.ConditionEnvironment = lib.mkForce "HYPRLAND_INSTANCE_SIGNATURE";

  services.hypridle = {
    enable = true;
    settings = {
      general = {
        after_sleep_cmd = "hyprctl dispatch dpms on";
        before_sleep_cmd = "loginctl lock-session";
        lock_cmd = "hyprlock --grace 60";
      };

      listener = [
        {
          timeout = 300; # 2min
          on-timeout = "loginctl lock-session";
        }
        # Screen of
        {
          timeout = 360;
          on-timeout = "hyprctl dispatch dpms off"; # screen off
          on-resume = "hyprctl dispatch dpms on";
        }
      ];
    };
  };
}
