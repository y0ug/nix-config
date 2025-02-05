{ pkgs, ... }:
{
  home.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.noto
    noto-fonts-emoji
    gnome-font-viewer
    font-awesome
    nwg-look
    # google-fonts.inter
  ];

  home.pointerCursor = {
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 16;
    gtk.enable = true;
    x11.enable = true;
  };

  gtk = {
    enable = true;

    iconTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };
    #
    # iconTheme = {
    #   name = "Numix-Dark-Gtk";
    #   package = pkgs.numix-icon-theme;
    # };
    theme = {
      name = "adw-gtk3-dark";
      package = pkgs.adw-gtk3;
    };

    # theme = {
    #   name = "Tokyonight-Dark";
    #   package = pkgs.tokyo-night-gtk;
    # };
    # font = {
    #   name = "Noto Color Emoji";
    #   # package = pkgs.nerd-fonts.noto;
    #   # name = "Inter";
    #   # package = pkgs.google-fonts.override { fonts = [ "Inter" ]; };
    #   size = 11;
    # };
  };

}
