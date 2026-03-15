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
        timeout = 360; # 6 min - turn off screens
        command = "${pkgs.sway}/bin/swaymsg 'output * dpms off'";
        resumeCommand = "${pkgs.sway}/bin/swaymsg 'output * dpms on'";
      }
      {
        timeout = 390; # 6 min 30s - lock 30s after screens off
        command = "${pkgs.systemd}/bin/loginctl lock-session";
      }
    ];
    events = [
      {
        event = "before-sleep";
        command = "${pkgs.systemd}/bin/loginctl lock-session";
      }
      {
        event = "lock";
        command = "${pkgs.swaylock}/bin/swaylock -f";
      }
    ];
  };

  # Only start swayidle when SWAYSOCK is set (i.e., in Sway)
  systemd.user.services.swayidle.Unit.ConditionEnvironment = lib.mkForce "SWAYSOCK";
}
