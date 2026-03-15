# https://github.com/LucaAAntonelli/nixos-config
{
  # test
  description = "NixOS configuration";

  inputs = {
    # nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.11";
    # nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager-stable = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };
    ida-pro-overlay = {
      url = "github:msanft/ida-pro-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    elephant.url = "github:abenz1267/elephant";

    walker = {
      url = "github:abenz1267/walker";
      inputs.elephant.follows = "elephant";
    };
    binaryninja = {
      url = "github:jchv/nix-binary-ninja";
      inputs.nixpkgs.follows = "nixpkgs";
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
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix-stable = {
      url = "github:danth/stylix/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };
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
    # glovebox.url = "github:/caddyglow/zmk-glovebox?ref=main";
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      nixpkgs-stable,
      stylix,
      stylix-stable,
      nix-darwin,
      home-manager,
      home-manager-stable,
      # glovebox,
      ida-pro-overlay,
      # elephant,
      # walker,
      binaryninja,
      # hyprland,
      # hyprland-plugins,
      ...
    }:
    let
      commonOverlays = import ./modules/overlays/default.nix { inherit ida-pro-overlay; };
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
        specialArgs = {
          inherit inputs username;
        };
        modules = [
          ./hosts/levua/configuration.nix
          { users.users.rick.home = "/Users/rick"; }
          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = false;
            home-manager.useUserPackages = true;
            home-manager.users.rick = import ./home/darwin.nix;
            home-manager.extraSpecialArgs = {
              inherit inputs;
              stylixAvailable = inputs ? stylix;
            };
          }
        ];
      };

      nixosConfigurations."nixos-vm" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit inputs username;
        };
        modules = [
          stylix.nixosModules.stylix
          ./hosts/nixos-vm/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = false;
            home-manager.useUserPackages = true;
            home-manager.users.rick = import ./home/nixos-vm.nix;
            home-manager.extraSpecialArgs = {
              inherit inputs;
              stylixAvailable = inputs ? stylix;
            };
          }
        ];
      };

      nixosConfigurations."culixa" = nixpkgs-stable.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit inputs username;
        };
        modules = [
          (
            { config, pkgs, ... }:
            {
              nixpkgs.overlays = commonOverlays;

              nixpkgs.config.allowUnfree = true;

            }
          )
          stylix-stable.nixosModules.stylix
          ./hosts/culixa/configuration.nix
          home-manager-stable.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = false;
            home-manager.useUserPackages = true;
            home-manager.users.rick = import ./home/culixa.nix;
            home-manager.sharedModules = [
              {
                nixpkgs.config.allowUnfree = true;
              }
            ];
            home-manager.extraSpecialArgs = {
              inherit inputs;
              stylixAvailable = inputs ? stylix;
            };
          }
        ];
      };

      nixosConfigurations."toxora" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit inputs username;
        };
        modules = [
          (
            { config, pkgs, ... }:
            {
              nixpkgs.overlays = commonOverlays;
              nixpkgs.config.allowUnfreePredicate =
                pkg:
                builtins.elem (nixpkgs.lib.getName pkg) [
                  "claude-code"
                ];
            }
          )
          stylix.nixosModules.stylix
          ./hosts/toxora/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = false;
            home-manager.useUserPackages = true;
            home-manager.users.rick = import ./home/toxora.nix;
            home-manager.sharedModules = [
              {
                nixpkgs.config.permittedInsecurePackages = [
                  "python3.13-ecdsa-0.19.1"
                ];
              }
            ];
            home-manager.extraSpecialArgs = {
              inherit inputs;
              stylixAvailable = inputs ? stylix;
            };
          }
        ];
      };

      nixosConfigurations."installer" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/installer/configuration.nix
        ];
      };

      homeConfigurations = {
        linux64-rick = inputs.home-manager.lib.homeManagerConfiguration {
          # pkgs = import nixpkgs {
          #   system = "x86_64-linux";
          #   config = { };
          # };
          modules = [ ./home/linux.nix ];
          extraSpecialArgs = {
            inherit inputs;
            stylixAvailable = inputs ? stylix;
          };
        };

        osx-rick = inputs.home-manager.lib.homeManagerConfiguration {
          # pkgs = import nixpkgs {
          #   system = "aarch64-darwin";
          #   config = { };
          # };
          modules = [ ./home/darwin.nix ];
          extraSpecialArgs = {
            inherit inputs;
            stylixAvailable = inputs ? stylix;
          };
        };

      };
    };
}
