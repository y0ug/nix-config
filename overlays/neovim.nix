{
  config,
  pkgs,
  lib,
}:

final: prev:
let
  cfg = config.programs.neovim-custom;

  neovimConfig = prev.neovimUtils.makeNeovimConfig {
    withPython3 = cfg.withPython3;
    withRuby = cfg.withRuby;
    withNodeJs = cfg.withNodeJs;
    extraPython3Packages = cfg.extraPython3Packages;
    extraLuaPackages = cfg.extraLuaPackages;
    extraPackages = cfg.extraPackages;
    customRC = "luafile ${cfg.configFile}";
    plugins = cfg.plugins;
  };
in
{
  neovim-custom = prev.wrapNeovimUnstable (prev.neovim-unwrapped.overrideAttrs (oldAttrs: {
    buildInputs = oldAttrs.buildInputs ++ [ prev.tree-sitter ];
  })) neovimConfig;
}
