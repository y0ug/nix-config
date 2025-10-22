{ ... }:
let
  moduleDir = ./.;
  childNames = builtins.attrNames (builtins.readDir moduleDir);
  moduleNames =
    builtins.filter
      (name:
        name != "default.nix"
        && builtins.match ".*\\.nix$" name != null
      )
      childNames;
in
{
  imports = map (name: moduleDir + "/${name}") moduleNames;
}
