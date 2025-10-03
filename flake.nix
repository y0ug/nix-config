# https://github.com/LucaAAntonelli/nixos-config
{
  # test
  description = "NixOS configuration";

  inputs = {
    # nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ida-pro-overlay = {
      url = "github:msanft/ida-pro-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    elephant = {
      url = "github:abenz1267/elephant";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.systems.follows = "systems";
    };

    # hyprswitch.url = "github:h3rmt/hyprswitch/release";
    # hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    # hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1&ref=v0.47.2-b";
    # hyprland-plugins = {
    #   url = "github:hyprwm/hyprland-plugins";
    #   inputs.hyprland.follows = "hyprland"; # Prevents version mismatch.
    # };
    # hy3 = {
    #   url = "github:outfoxxed/hy3?ref=hl0.48.0"; # where {version} is the hyprland release version
    #   # or "github:outfoxxed/hy3" to follow the development branch.
    #   # (you may encounter issues if you dont do the same for hyprland)
    #   inputs.hyprland.follows = "hyprland";
    # };
    stylix.url = "github:danth/stylix";
    # agenix = {
    #   url = "github:ryantm/agenix";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    #
    # deploy-rs = {
    #   url = "github:serokell/deploy-rs";
    #   inputs.nixpkgs.follows = "nixpkgs";
    #   inputs.utils.follows = "flake-utils";
    # };
    #
    # pre-commit-hooks = {
    #   url = "github:cachix/pre-commit-hooks.nix";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    # glovebox.url = "git+ssh://git@github.com:/caddyglow/zmk-glovebox.git?ref=main";
    glovebox.url = "github:/caddyglow/zmk-glovebox?ref=main";
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      stylix,
      nix-darwin,
      home-manager,
      glovebox,
      ida-pro-overlay,
      elephant,
      # hyprland,
      # hyprland-plugins,
      ...
    }:
    let
      # Define your custom overlay
      customPkgsOverlay = selfPkgs: superPkgs: {
        # You can namespace your packages if you like, e.g., mycustom.hints
        # Or add them directly to pkgs
        hints = superPkgs.callPackage ./modules/packages/python/hints.nix {
          # Pass any specific dependencies from pkgs if hints.nix needed them
          # beyond what callPackage automatically provides.
          # For your current hints.nix, this is usually enough.
        };
        # If you had other custom packages:
        # anotherCoolPackage = superPkgs.callPackage ./packages/another/package.nix {};
      };

      # List of overlays to apply. Your ida-pro-overlay also provides one.
      commonOverlays = [
        customPkgsOverlay
        ida-pro-overlay.overlays.default
      ];
      username = "rick";
    in
    {
      # formatter.${system} = nixpkgs.legacyPackages.${system}.alejandra;
      darwinConfigurations."levua" = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        pkgs = import nixpkgs {
          system = "aarch64-darwin";
          config = {
            allowUnfreePredicate = pkg: builtins.elem (nixpkgs.lib.getName pkg) [ "vscode" ];
          };
        };
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/levua/configuration.nix
          { users.users.rick.home = "/Users/rick"; }
          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = false;
            home-manager.useUserPackages = true;
            home-manager.users.rick = import ./home/darwin.nix;
            home-manager.extraSpecialArgs = { inherit inputs; };
          }
        ];
      };

      nixosConfigurations."nixos-vm" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          stylix.nixosModules.stylix
          ./hosts/nixos-vm/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = false;
            home-manager.useUserPackages = true;
            home-manager.users.rick = import ./home/nixos-vm.nix;
            home-manager.extraSpecialArgs = { inherit inputs; };
          }
        ];
      };

      nixosConfigurations."culixa" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          (
            { config, pkgs, ... }:
            {
              nixpkgs.overlays = commonOverlays;

              nixpkgs.config.allowUnfreePredicate =
                pkg:
                builtins.elem (nixpkgs.lib.getName pkg) [
                  "claude-code"
                  "ida-pro"
                ];

            }
          )
          stylix.nixosModules.stylix
          ./hosts/culixa/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = false;
            home-manager.useUserPackages = true;
            home-manager.users.rick = import ./home/culixa.nix;
            home-manager.extraSpecialArgs = { inherit inputs; };
          }
        ];
      };

      homeConfigurations = {
        linux64-rick = inputs.home-manager.lib.homeManagerConfiguration {
          # pkgs = import nixpkgs {
          #   system = "x86_64-linux";
          #   config = { };
          # };
          modules = [ ./home/linux.nix ];
          extraSpecialArgs = { inherit inputs; };
        };

        osx-rick = inputs.home-manager.lib.homeManagerConfiguration {
          # pkgs = import nixpkgs {
          #   system = "aarch64-darwin";
          #   config = { };
          # };
          modules = [ ./home/darwin.nix ];
          extraSpecialArgs = { inherit inputs; };
        };

      };
    };
}
