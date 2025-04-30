{ config, pkgs, ... }:
{
  imports = [
    ../modules/home/desktop.nix
    ../modules/home/packages/work.nix
  ];

  home.username = "rick";
  home.homeDirectory = "/home/rick";
  home.stateVersion = "24.05";

  home.packages = with pkgs; [
    firefox
    grc
  ];

  # programs.zsh.enabled = true;

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "inode/directory" = "files.desktop";

      # librewolf as my default browser
      "text/html" = "librewolf.desktop";
      "x-scheme-handler/http" = "librewolf.desktop";
      "x-scheme-handler/https" = "librewolf.desktop";
      "x-scheme-handler/mailto" = "librewolf.desktop";
      "x-scheme-handler/webcal" = "librewolf.desktop";
      "x-scheme-handler/unknown" = "librewolf.desktop";

      # Use file-roller for archives
      "application/x-7z-compressed" = "org.gnome.FileRoller.desktop";
      "application/x-bzip-compressed-tar" = "org.gnome.FileRoller.desktop";
      "application/x-compressed-tar" = "org.gnome.FileRoller.desktop";
      "application/x-gzip-compressed-tar" = "org.gnome.FileRoller.desktop";
      "application/x-rar-compressed" = "org.gnome.FileRoller.desktop";
      "application/x-tar" = "org.gnome.FileRoller.desktop";
      "application/x-xz-compressed-tar" = "org.gnome.FileRoller.desktop";
      "application/zip" = "org.gnome.FileRoller.desktop";
    };
  };

  # programs.fish = {
  #   enable = true;
  #   interactiveShellInit = ''
  #     set fish_greeting # Disable greeting
  #   '';
  #   plugins = [
  #     {
  #       name = "grc";
  #       src = pkgs.fishPlugins.grc.src;
  #     }
  #     {
  #       name = "hydro";
  #       src = pkgs.fishPlugins.hydro.src;
  #     }
  #     {
  #       name = "done";
  #       src = pkgs.fishPlugins.done.src;
  #     }
  #     {
  #       name = "fzf.fish";
  #       src = pkgs.fishPlugins.fzf-fish.src;
  #     }
  #     {
  #       name = "z";
  #       src = pkgs.fishPlugins.z.src;
  #     }
  #     {
  #       name = "sponge";
  #       src = pkgs.fishPlugins.sponge.src;
  #     }
  #
  #   ];
  # };
}
