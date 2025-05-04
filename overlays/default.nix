{ inputs, ... }:

{
  nixpkgs.overlays = [
    # Import all overlay files
    (import ./neovim.nix)
    (import ./devenv.nix)
    (import ./aider.nix)

    (final: prev: {
      # customPackage = prev.customPackage.override { ... };
    })
  ];
}
