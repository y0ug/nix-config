{ pkgs, inputs, ... }:
{
  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      substituters = [
        "https://nix-community.cachix.org"
        "https://cache.nixos.org/"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      ];
      trusted-users = [
        "root"
        "wheel"
      ];
    };
  };

  time.timeZone = "Europe/Paris";
  # time.hardwareClockInLocalTime = true;
  i18n.defaultLocale = "en_US.UTF-8";

  home-manager.backupFileExtension =
    "backup-"
    + pkgs.lib.readFile "${pkgs.runCommand "timestamp" { } "echo -n `date '+%Y%m%d%H%M%S'` > $out"}";

}
