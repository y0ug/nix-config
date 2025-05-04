{ pkgs, ... }:

{
  imports = [
    ../packages/work.nix
  ];
  
  # Development-specific system packages
  environment.systemPackages = with pkgs; [
    # Version control
    git
    git-lfs
    
    # Editors
    neovim
    
    # Build tools
    gnumake
    cmake
    
    # Development tools
    devenv
    direnv
  ];
  
  # Enable Docker
  virtualisation.docker.enable = true;
  
  # System configuration for development
  nix.settings = {
    trusted-substituters = [
      "https://devenv.cachix.org"
    ];
  };
  
  # neovim configuration
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    configure = {
      extraLuaPackages = p: [
        p.magick
        p.tiktoken_core
      ];
      extraPython3Packages = p: with p; [
        pynvim
        jupyter-client
        cairosvg
        ipython
        nbformat
      ];
      extraPackages = p: [
        p.imagemagick
      ];
      withNodeJs = true;
      withRuby = true;
      withPython3 = true;
    };
  };
}