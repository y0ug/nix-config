{ ... }: {
  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;
  
  services.gnome.gnome-settings-daemon = {
    enable = true;
    extraConfig = ''
      [org/gnome/settings-daemon/plugins/power]
      sleep-inactive-ac-timeout=0
      sleep-inactive-battery-timeout=0
      sleep-inactive-ac-type='nothing'
      sleep-inactive-battery-type='nothing'
    '';
  };
}
