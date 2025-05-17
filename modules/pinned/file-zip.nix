{
  config,
  lib,
  pkgs,
  ...
}:

let
  # Pin to specific commit for file 5.42 with zip patch
  # https://github.com/file/file/commit/60b2032b96fc185b37fb0f2152e834efb2edad6e
  # https://bugs.astron.com/view.php?id=571
  # They revert the patch here https://github.com/NixOS/nixpkgs/commit/02b5fe25a4065bb65375cb7186a6355447d12934#diff-394aee9384c267054f9fc0139ec1abcebebfbbbeceb2432ef446a7c902e78eeb
  # https://github.com/NixOS/nixpkgs/pull/407304
  # jj
  devenvPkgs = import (builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/d86fe97.tar.gz";
    sha256 = "0yf5ggdfwny8iqk9pwb3bmahyj29z9b06vkmkhcy189wx8ivr473";
    # hash = "sha256:0000000000000000000000000000000000000000000000000000";
  }) { system = pkgs.stdenv.hostPlatform.system; };
in
{
  options = {
    programs.devenv = {
      enable = lib.mkEnableOption "Enable pinned version";
    };
  };

  # config = lib.mkIf config.programs.file.enable {
  config = {
    environment.systemPackages = [
      devenvPkgs.file
    ];
  };
}
