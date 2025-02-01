{ config, pkgs, ... }:

{
  # imports = let
  #   programFiles = builtins.attrNames (builtins.readDir ./.);
  #   filteredPrograms =
  #     builtins.filter (name: name != "default.nix") programFiles;
  # in map (name: ./. + "/${name}") filteredPrograms;
  imports = [
    ./audio.nix
    ./fonts.nix
    ./program.nix
    ./security.nix
    ./services.nix
    ./xserver.nix
  ];
}
