{
  config,
  lib,
  pkgs,
  ...
}:

let
  # Pin to specific commit for devenv 1.5.1
  devenvPkgs = import (builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/166de8f.tar.gz";
    sha256 = "0000000000000000000000000000000000000000000000000000"; # Replace with actual hash
  }) { };
in
{
  options = {
    programs.devenv = {
      enable = lib.mkEnableOption "Enable pinned devenv version";
    };
  };

  config = lib.mkIf config.programs.devenv.enable {
    environment.systemPackages = [
      devenvPkgs.devenv
    ];
  };
}
