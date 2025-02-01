{ pkgs, username, ... }: {
  programs.zsh.enable = true;

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  users.users.${username} = {
    isNormalUser = true;
    description = "${username}";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIILPlZ1DnETw4zdAVGB4uQL/MBj42qmPU3nzaR6g4SEe rick@mazenet.org"
    ];
  };
  nix.settings.allowed-users = [ "${username}" ];
}
