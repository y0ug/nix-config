{ config, pkgs, ... }: {
  imports = [ 
  ../../modules/home/desktop.nix
  ]
  

  home.username = "rick";
  home.homeDirectory = "/home/rick";
  home.stateVersion = "24.05";

  home.packages = with pkgs; [ firefox ];

}
