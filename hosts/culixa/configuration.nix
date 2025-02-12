{
  inputs,
  config,
  pkgs,
  stylix,
  ...
}:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../modules/core/system.nix
    ../../modules/core/GUI
    ../../modules/core/GUI/nestedvm.nix
    # ../../modules/core/GUI/gnome.nix
    ../../modules/core/GUI/hyprland.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.extraModprobeConfig = "options kvm_intel nested=1";

  nixpkgs.config.allowUnfree = true;

  networking.hostName = "culixa";

  # Enable networking
  networking.networkmanager.enable = true;

  # Bluetooth
  services.blueman.enable = true;
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  # Enabling A2DP Sink
  hardware.bluetooth.settings = {
    General = {
      Enable = "Source,Sink,Media,Socket";
      Experimental = true; # to get battery status
    };
  };

  security.sudo.extraConfig = ''
    Defaults timestamp_timeout=120 # 2 hours timeout
    # Defaults env_keep+=SSH_AUTH_SOCK
    # Defaults env_keep+=EDITOR
  '';

  # Docker
  virtualisation.docker.enable = true;

  # Virt-manager and qemu
  programs.virt-manager.enable = true;
  users.groups.libvirtd.members = [ "rick" ];
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;

  programs.zsh.enable = true;
  programs.zsh.enableCompletion = false;

  # programs.bash.enable = true;
  programs.bash.completion.enable = true;

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  users.users.rick = {
    isNormalUser = true;
    description = "rick";
    extraGroups = [
      "docker"
      "networkmanager"
      "wheel"
    ];
    shell = pkgs.bash;
    packages = with pkgs; [ ];
  };

  stylix.enable = true;
  stylix.image = pkgs.fetchurl {
    url = "https://www.pixelstalk.net/wp-content/uploads/2016/05/Epic-Anime-Awesome-Wallpapers.jpg";
    sha256 = "enQo3wqhgf0FEPHj2coOCvo7DuZv+x5rL/WIo4qPI50=";
  };

  stylix = {
    autoEnable = true;
    polarity = "dark";
    # image = "${opts.wallpaper}";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyodark.yaml";

    opacity = {
      terminal = 0.9;
      popups = 0.8;
    };

    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 24;
    };

    fonts = {
      # serif = config.stylix.fonts.monospace;
      # sansSerif = config.stylix.fonts.monospace;
      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Nerd Font";
      };
    };
  };
  environment.systemPackages = with pkgs; [ libinput ];

  environment.localBinInPath = true;

  # allow non-nix executable
  programs.nix-ld.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      vpl-gpu-rt # for newer GPUs on NixOS >24.05 or unstable
    ];
  };

  services.sunshine = {
    enable = true;
    autoStart = true;
    capSysAdmin = true;
    openFirewall = true;
  };

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [
      22
      47984
      47989
      47990
      48010
    ];
    allowedUDPPortRanges = [
      {
        from = 47998;
        to = 48000;
      }
      {
        from = 8000;
        to = 8010;
      }
    ];
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ 22 ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. ItΓÇÿs perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}
