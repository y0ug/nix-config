{
  pkgs,
  lib,
  ...
}:
{
  services.swayidle = {
    enable = true;
    systemdTarget = "graphical-session.target";
    timeouts = [
      {
        timeout = 300; # 5 min
        command = "${pkgs.systemd}/bin/loginctl lock-session";
      }
      {
        timeout = 360; # 6 min
        command = "${pkgs.sway}/bin/swaymsg 'output * dpms off'";
        resumeCommand = "${pkgs.sway}/bin/swaymsg 'output * dpms on'";
      }
    ];
    events = {
      before-sleep = "${pkgs.systemd}/bin/loginctl lock-session";
      lock = "${pkgs.swaylock}/bin/swaylock -f";
    };
  };

  # Only start swayidle when SWAYSOCK is set (i.e., in Sway)
  systemd.user.services.swayidle.Unit.ConditionEnvironment = lib.mkForce "SWAYSOCK";
}
