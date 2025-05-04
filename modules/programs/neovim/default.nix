# modules/programs/neovim/default.nix
{
  config,
  lib,
  pkgs,
  ...
}:

with lib;

let
  cfg = config.programs.neovim-custom;
in
{
  imports = [
    # Any submodules if needed
  ];

  options.programs.neovim-custom = {
    enable = mkEnableOption "Enable customized Neovim";

    defaultEditor = mkOption {
      type = types.bool;
      default = false;
      description = "Whether to set Neovim as the default editor";
    };

    withPython3 = mkOption {
      type = types.bool;
      default = true;
      description = "Enable Python 3 support";
    };

    withRuby = mkOption {
      type = types.bool;
      default = true;
      description = "Enable Ruby support";
    };

    withNodeJs = mkOption {
      type = types.bool;
      default = true;
      description = "Enable Node.js support";
    };

    extraPython3Packages = mkOption {
      type = types.functionTo (types.listOf types.package);
      default = p: [ ];
      description = "Extra Python 3 packages to add to Neovim";
    };

    extraLuaPackages = mkOption {
      type = types.functionTo (types.listOf types.package);
      default = p: [ ];
      description = "Extra Lua packages to add to Neovim";
    };

    extraPackages = mkOption {
      type = types.functionTo (types.listOf types.package);
      default = p: [ ];
      description = "Extra packages to add to Neovim";
    };

    configFile = mkOption {
      type = types.str;
      default = "~/.config/nvim/init.lua";
      description = "Path to user's Neovim configuration file";
    };

    plugins = mkOption {
      type = types.listOf types.package;
      default = [ ];
      description = "List of plugins to install";
    };
  };

  config = mkIf cfg.enable {
    nixpkgs.overlays = [
      (import ./overlay.nix { inherit config pkgs lib; })
    ];

    environment.systemPackages = with pkgs; [
      luarocks
      lua5_1
      luajit
      neovim-custom
      icu
      # Additional Python packages in path
      python3Packages.jupytext # for vim-jupytext
    ];

    programs.neovim = {
      enable = true;
      defaultEditor = cfg.defaultEditor;
      package = pkgs.neovim-custom;
    };
  };
}
