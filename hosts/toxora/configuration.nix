{
  inputs,
  config,
  pkgs,
  stylix,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/core/nix-settings.nix
    ../../modules/core/workstation.nix
    ../../modules/core/gui
    ../../modules/core/gui/session-manager.nix
    ../../modules/core/gui/hyprland.nix
    ../../modules/core/gui/niri.nix
    ../../modules/core/gui/sway.nix
  ];

  # Bootloader
  boot.loader = {
    timeout = 1;
    systemd-boot.enable = true;
    systemd-boot.configurationLimit = 5;
  };
  boot.loader.efi.canTouchEfiVariables = true;
  boot.extraModprobeConfig = "options kvm_intel nested=1";

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      vpl-gpu-rt
      intel-media-driver
      intel-compute-runtime
      libvdpau-va-gl
    ];
  };

  hardware.enableRedistributableFirmware = true;
  hardware.keyboard.qmk.enable = true;
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [
    "python3.13-ecdsa-0.19.1"
  ];

  networking.hostName = "toxora";
  networking.useDHCP = false;
  networking.useNetworkd = true;
  networking.networkmanager.enable = false;

  # WiFi via IWD
  networking.wireless.enable = false;
  networking.wireless.iwd = {
    enable = true;
    settings = {
      General.Country = "FR";
      Network = {
        EnableIPv6 = true;
        RoutePriorityOffset = 300;
      };
      Settings.AutoConnect = true;
    };
  };

  systemd.services.networkd-wait-online.enable = false;
  systemd.network = {
    enable = true;
    wait-online.anyInterface = true;
    networks = {
      "30-wireless" = {
        matchConfig.Type = "wlan";
        networkConfig = {
          DHCP = "ipv4";
          IPv6AcceptRA = true;
        };
        linkConfig.RequiredForOnline = "routable";
      };
      "30-ethernet" = {
        matchConfig.Type = "ether";
        networkConfig = {
          DHCP = "ipv4";
          IPv6AcceptRA = true;
        };
        linkConfig.RequiredForOnline = "no";
      };
    };
  };

  # Bluetooth
  services.blueman.enable = true;
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  hardware.bluetooth.settings = {
    General = {
      Enable = "Source,Sink,Media,Socket";
      Experimental = true;
    };
  };

  security.sudo.extraConfig = ''
    Defaults timestamp_timeout=120
    Defaults env_keep+=SSH_AUTH_SOCK
    Defaults env_keep+=EDITOR
  '';

  # Docker
  virtualisation.docker = {
    enable = true;
    enableOnBoot = false;
    daemon.settings = {
      dns = [ "8.8.8.8" "1.1.1.1" ];
    };
  };
  systemd.services.docker = {
    wants = [ "docker.socket" ];
  };

  # Virt-manager and qemu
  programs.virt-manager.enable = true;
  users.groups.libvirtd.members = [ "rick" ];
  users.groups.pcap.members = [ "rick" ];
  users.groups.wireshark.members = [ "rick" ];
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;

  programs.tcpdump.enable = true;
  programs.wireshark.enable = true;

  programs.zsh = {
    enable = true;
  };
  programs.fish = {
    enable = true;
  };
  programs.bash.completion.enable = true;
  programs.direnv.enable = true;
  services.lorri.enable = true;

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  users.users.rick = {
    isNormalUser = true;
    description = "rick";
    extraGroups = [
      "users"
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

  stylix = {
    enable = true;
    autoEnable = true;
    polarity = "dark";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-frappe.yaml";
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
      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Nerd Font";
      };
      emoji = {
        package = pkgs.noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };
    };
  };

  environment.systemPackages = with pkgs; [
    libinput
    nix-zsh-completions
    via
    zsh-nix-shell
    pinentry-curses
    pamixer
  ];

  environment.localBinInPath = true;
  programs.nix-ld.enable = true;

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    enableBrowserSocket = true;
    settings = { };
  };

  services = {
    eternal-terminal.enable = true;
    openssh.enable = true;
    pcscd.enable = true;
    udev.packages = [
      pkgs.yubikey-personalization
      pkgs.via
    ];
  };

  networking.nftables.enable = true;
  networking.firewall.enable = false;

  system.stateVersion = "25.11";

  security.polkit.enable = true;
  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
      if (action.id == "org.freedesktop.udisks2.filesystem-mount" ||
          action.id == "org.freedesktop.udisks2.encrypted-unlock") {
        return polkit.Result.YES;
      }
    });
  '';

  security.pki.certificateFiles = [ ../../certs/mitmproxy-ca-cert.pem ];
  programs.mosh.enable = true;
}
