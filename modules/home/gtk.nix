{ pkgs, ... }:
{
  fonts.fontconfig.enable = true;

  # Noto Color Emoji doesn't render on Firefox
  # fonts.fontconfig.useEmbeddedBitmaps = true;

  home.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.noto
    twemoji-color-font
    noto-fonts-emoji
    gruvbox-dark-icons-gtk
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

    # theme = {
    #   name = "adw-gtk3-dark";
    #   package = pkgs.adw-gtk3;
    # };

    theme = {
      name = "Tokyonight-Dark";
      package = pkgs.tokyo-night-gtk;
    };
    font = {
      name = "Inter";
      package = pkgs.google-fonts.override { fonts = [ "Inter" ]; };
      size = 9;
    };
  };

}
