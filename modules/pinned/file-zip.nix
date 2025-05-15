{
  config,
  lib,
  pkgs,
  ...
}:

let
  # Pin to specific commit for file 5.42 with zip patch
  devenvPkgs = import (builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/02b5fe2.tar.gz";
    sha256 = "0000000000000000000000000000000000000000000000000000000000000000";
    # hash = "sha256:0000000000000000000000000000000000000000000000000000";
  }) { system = pkgs.stdenv.hostPlatform.system; };
in
{
  options = {
    programs.devenv = {
      enable = lib.mkEnableOption "Enable pinned version";
    };
  };

  config = lib.mkIf config.programs.devenv.enable {
    environment.systemPackages = [
      devenvPkgs.devenv
    ];
  };
}
