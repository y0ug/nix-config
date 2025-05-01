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
    ../../modules/core/nvim.nix
    ../../modules/core/GUI
    ../../modules/core/GUI/nestedvm.nix
    # ../../modules/core/GUI/gnome.nix
    ../../modules/core/GUI/hyprland.nix
    # ../../modules/pinned/devenv-1.5.1.nix
    ../../modules/core/flatpak.nix
    ../../modules/core/udev-rules.nix

  ];
  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      substituters = [
        "https://nix-community.cachix.org"
        "https://cache.nixos.org/"
        "https://devenv.cachix.org"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
      ];
      trusted-users = [
        "root"
        "wheel"
        "rick"
      ];
    };
  };
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = [ "zfs" ];
  boot.zfs.forceImportRoot = false;
  networking.hostId = "95166fcd";
  boot.extraModprobeConfig = "options kvm_intel nested=1";

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      vpl-gpu-rt # for newer GPUs on NixOS >24.05 or unstable
      intel-media-driver
      intel-compute-runtime
      libvdpau-va-gl
    ];
  };

  hardware.keyboard.qmk.enable = true;
  # nixpkgs.config.allowUnfree = true;

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
    Defaults env_keep+=SSH_AUTH_SOCK
    Defaults env_keep+=EDITOR
  '';

  # Docker
  virtualisation.docker.enable = true;

  # Virt-manager and qemu
  programs.virt-manager.enable = true;
  users.groups.libvirtd.members = [ "rick" ];
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;

  programs.zsh = {
    enable = true;
    # enableCompletion = true;
    # enableBashCompletion = true;
  };

  programs.fish = {
    enable = true;
  };

  # programs.bash.enable = true;
  programs.bash.completion.enable = true;

  # programs.devenv.enable = true;

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
      "plugdev"
      "video"
      "render"
    ];
    shell = pkgs.zsh;
    packages = with pkgs; [ ];
  };

  # https://github.com/tinted-theming/schemes/tree/spec-0.11/base16
  stylix = {
    enable = true;
    autoEnable = true;
    polarity = "dark";
    base16Scheme = "${toString ../../modules/themes/stylix/arctic_vs_dark.yaml}";

    # base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyodark.yaml";
    opacity = {
      terminal = 1.0;
      popups = 1.0;
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
      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
    };
  };

  environment.systemPackages = with pkgs; [
    libinput
    nix-zsh-completions
    via # qmk userland customization
    zsh-nix-shell
    pinentry-curses
  ];

  environment.localBinInPath = true;

  # allow non-nix executable
  programs.nix-ld.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    enableBrowserSocket = true;
    pinentryProgram = pkgs.pinentry-curses;
    settings = { };
  };

  # List services that you want to enable:

  services = {
    openssh.enable = true;
    yubikey-agent.enable = true;
    pcscd.enable = true; # smart card reader daemon
    udev.packages = [
      pkgs.yubikey-personalization
      pkgs.via
    ];
    sunshine = {
      enable = true;
      autoStart = true;
      capSysAdmin = true;
      openFirewall = true;
    };
  };
  # Enable the OpenSSH daemon.

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

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. ItΓÇÿs perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

  security.polkit.enable = true;
  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
      if (action.id == "org.freedesktop.udisks2.filesystem-mount" ||
          action.id == "org.freedesktop.udisks2.encrypted-unlock") {
        return polkit.Result.YES;
      }
    });
  '';

}
