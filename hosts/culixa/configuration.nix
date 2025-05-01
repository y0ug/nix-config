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

  services.udev.packages = [ pkgs.via ];
  environment.localBinInPath = true;

  # allow non-nix executable
  programs.nix-ld.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    settings = {
      ignore-cache-errors = true;
    };
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

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

  security.polkit.enable = true;
  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
      if (action.id == "org.freedesktop.udisks2.filesystem-mount" ||
          action.id == "org.freedesktop.udisks2.encrypted-unlock") {
        return polkit.Result.YES;
      }
    });
  '';

  services.udev.extraRules = ''
    # annerpro flash mode 04d9:8008
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="04d9", ATTRS{idProduct}=="8009", TAG+="uaccess"
    # Atmel DFU
    ### ATmega16U2
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="03eb", ATTRS{idProduct}=="2fef", TAG+="uaccess"
    ### ATmega32U2
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="03eb", ATTRS{idProduct}=="2ff0", TAG+="uaccess"
    ### ATmega16U4
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="03eb", ATTRS{idProduct}=="2ff3", TAG+="uaccess"
    ### ATmega32U4
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="03eb", ATTRS{idProduct}=="2ff4", TAG+="uaccess"
    ### AT90USB64
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="03eb", ATTRS{idProduct}=="2ff9", TAG+="uaccess"
    ### AT90USB162
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="03eb", ATTRS{idProduct}=="2ffa", TAG+="uaccess"
    ### AT90USB128
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="03eb", ATTRS{idProduct}=="2ffb", TAG+="uaccess"

    # Input Club
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="1c11", ATTRS{idProduct}=="b007", TAG+="uaccess"

    # STM32duino
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="1eaf", ATTRS{idProduct}=="0003", TAG+="uaccess"
    # STM32 DFU
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="df11", TAG+="uaccess"

    # BootloadHID
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="05df", TAG+="uaccess"

    # USBAspLoader
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="05dc", TAG+="uaccess"

    # USBtinyISP
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="1782", ATTRS{idProduct}=="0c9f", TAG+="uaccess"

    # ModemManager should ignore the following devices
    # Atmel SAM-BA (Massdrop)
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="03eb", ATTRS{idProduct}=="6124", TAG+="uaccess", ENV{ID_MM_DEVICE_IGNORE}="1"

    # Caterina (Pro Micro)
    ## pid.codes shared PID
    ### Keyboardio Atreus 2 Bootloader
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="1209", ATTRS{idProduct}=="2302", TAG+="uaccess", ENV{ID_MM_DEVICE_IGNORE}="1"
    ## Spark Fun Electronics
    ### Pro Micro 3V3/8MHz
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="1b4f", ATTRS{idProduct}=="9203", TAG+="uaccess", ENV{ID_MM_DEVICE_IGNORE}="1"
    ### Pro Micro 5V/16MHz
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="1b4f", ATTRS{idProduct}=="9205", TAG+="uaccess", ENV{ID_MM_DEVICE_IGNORE}="1"
    ### LilyPad 3V3/8MHz (and some Pro Micro clones)
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="1b4f", ATTRS{idProduct}=="9207", TAG+="uaccess", ENV{ID_MM_DEVICE_IGNORE}="1"
    ## Pololu Electronics
    ### A-Star 32U4
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="1ffb", ATTRS{idProduct}=="0101", TAG+="uaccess", ENV{ID_MM_DEVICE_IGNORE}="1"
    ## Arduino SA
    ### Leonardo
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="2341", ATTRS{idProduct}=="0036", TAG+="uaccess", ENV{ID_MM_DEVICE_IGNORE}="1"
    ### Micro
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="2341", ATTRS{idProduct}=="0037", TAG+="uaccess", ENV{ID_MM_DEVICE_IGNORE}="1"
    ## Adafruit Industries LLC
    ### Feather 32U4
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="239a", ATTRS{idProduct}=="000c", TAG+="uaccess", ENV{ID_MM_DEVICE_IGNORE}="1"
    ### ItsyBitsy 32U4 3V3/8MHz
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="239a", ATTRS{idProduct}=="000d", TAG+="uaccess", ENV{ID_MM_DEVICE_IGNORE}="1"
    ### ItsyBitsy 32U4 5V/16MHz
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="239a", ATTRS{idProduct}=="000e", TAG+="uaccess", ENV{ID_MM_DEVICE_IGNORE}="1"
    ## dog hunter AG
    ### Leonardo
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="2a03", ATTRS{idProduct}=="0036", TAG+="uaccess", ENV{ID_MM_DEVICE_IGNORE}="1"
    ### Micro
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="2a03", ATTRS{idProduct}=="0037", TAG+="uaccess", ENV{ID_MM_DEVICE_IGNORE}="1"

    # hid_listen
    KERNEL=="hidraw*", MODE="0660", GROUP="plugdev", TAG+="uaccess", TAG+="udev-acl"

    # hid bootloaders
    ## QMK HID
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="03eb", ATTRS{idProduct}=="2067", TAG+="uaccess"
    ## PJRC's HalfKay
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="0478", TAG+="uaccess"

    # APM32 DFU
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="314b", ATTRS{idProduct}=="0106", TAG+="uaccess"

    # GD32V DFU
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="28e9", ATTRS{idProduct}=="0189", TAG+="uaccess"

    # WB32 DFU
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="342d", ATTRS{idProduct}=="dfa0", TAG+="uaccess"

    # AT32 DFU
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="2e3c", ATTRS{idProduct}=="df11", TAG+="uaccess"
  '';
}
