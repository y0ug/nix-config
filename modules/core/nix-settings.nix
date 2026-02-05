{ lib, ... }:
let
  defaultSubstituters = [
    "https://nix-community.cachix.org"
    "https://cache.nixos.org/"
    "https://devenv.cachix.org"
  ];
  defaultKeys = [
    "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
  ];
  defaultTrustedUsers = [
    "root"
    "wheel"
    "rick"
  ];
in
{
  nix.settings = {
    experimental-features = lib.mkDefault [
      "nix-command"
      "flakes"
    ];
    substituters = lib.mkDefault defaultSubstituters;
    trusted-public-keys = lib.mkDefault defaultKeys;
    trusted-users = lib.mkForce defaultTrustedUsers;
  };
}
