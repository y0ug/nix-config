{ pkgs, ... }:
{
  imports = [ ./nix-settings.nix ];

  time.timeZone = "Europe/Paris";
  # time.hardwareClockInLocalTime = true;
  i18n.defaultLocale = "en_US.UTF-8";

  home-manager.backupFileExtension =
    "backup-"
    + pkgs.lib.readFile "${pkgs.runCommand "timestamp" { } "echo -n `date '+%Y%m%d%H%M%S'` > $out"}";

  programs.appimage.binfmt = true;
  programs.command-not-found.enable = false;
  boot.binfmt.emulatedSystems = [
    "x86_64-windows"
  ];
}
