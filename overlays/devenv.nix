{ pkgs, ... }:

final: prev:
let
  # Pin to specific commit for devenv 1.5.1
  devenvPkgs = import (builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/166de9f.tar.gz";
    sha256 = "0ayi22hk3hj15w0z8d52wwy8wnm67x4cin8yzja7cyahfsp6j89n";
  }) { system = prev.stdenv.hostPlatform.system; };
in
{
  devenv-pinned = devenvPkgs.devenv;
}
