{
  description = "Nix flake for IDA Pro";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  };

  outputs =
    {
      ...
    }:
    {
      overlays.default = final: prev: {
        ida-pro = prev.callPackage ./packages/ida-pro.nix { };
      };
    };
}
