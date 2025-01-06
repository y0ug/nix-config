{
  description = "NixOS configuration";

  inputs = {
    # nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    nix-darwin ={
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };


    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    deploy-rs = {
      url = "github:serokell/deploy-rs";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.utils.follows = "flake-utils";
    };

    pre-commit-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = inputs@{ nixpkgs, nix-darwin, home-manager, ... }: 
    let
    username = "rick";
    in
      {
        # formatter.${system} = nixpkgs.legacyPackages.${system}.alejandra;
        darwinConfigurations."levua" = nix-darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          pkgs = import nixpkgs {
          system = "aarch64-darwin";
            config = {};
          };
          specialArgs = { inherit username; };
          modules = [
            ./darwin/configuration.nix
            home-manager.darwinModules.home-manager
            {
              # home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.rick = import ./home.nix;
              home-manager.extraSpecialArgs = { inherit inputs; };
            }
          ];
        };

        homeConfigurations = {
          linux64-rick = inputs.home-manager.lib.homeManagerConfiguration {
            pkgs = import nixpkgs {
              system = "x86_64-linux";
              config = {}; 
            };
            modules = [ ./home.nix ];
            extraSpecialArgs = { inherit inputs; };
          };

          osx-rick = inputs.home-manager.lib.homeManagerConfiguration {
            pkgs = import nixpkgs {
              system = "aarch64-darwin";
              config = {};
            };
            modules = [ ./home.nix ];
            extraSpecialArgs = { inherit inputs; };
          };
        };
      };
}

