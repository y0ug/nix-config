{ pkgs, ... }:

{
  imports = [
    ../packages/desktop.nix
    ../packages/linux.nix
    ./audio.nix
    ./fonts.nix
  ];
  
  # X11 Server
  services.xserver = {
    enable = true;
    xkb.layout = "us";
  };
  
  # System services
  services = {
    gvfs.enable = true;
    gnome.gnome-keyring.enable = true;
    devmon.enable = true;
    udisks2.enable = true;
    dbus.enable = true;
    fstrim.enable = true;
    printing.enable = true;
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
  };
  
  # Bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  hardware.bluetooth.settings = {
    General = {
      Enable = "Source,Sink,Media,Socket";
      Experimental = true;
    };
  };
  
  # Polkit for permission management
  security.polkit.enable = true;
  
  # XDG portal integration
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    xdgOpenUsePortal = false;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];
  };
}