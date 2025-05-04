{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Core utilities
    flake-utils.url = "github:numtide/flake-utils";
    flake-parts.url = "github:hercules-ci/flake-parts";

    # System management
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Theming and UI
    stylix.url = "github:danth/stylix";

    # Custom repos
    glovebox.url = "git+ssh://git@github.com:/y0ug/glovebox.git?ref=dev-refactort";
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      flake-parts,
      ...
    }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
      ];

      perSystem =
        {
          config,
          self',
          inputs',
          pkgs,
          system,
          ...
        }:
        {
          formatter = pkgs.nixpkgs-fmt;
          devShells.default = pkgs.mkShell {
            buildInputs = with pkgs; [
              nixpkgs-fmt
              nil
            ];
          };
        };

      imports = [
        ./hosts
        ./overlays
      ];
    };
}
