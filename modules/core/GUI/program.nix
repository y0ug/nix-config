{ ... }: 
{
  programs.dconf.enable = true;
  programs.zsh.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    # pinentryFlavor = "";
  };
  programs.ssh.enable = true;
  programs.nix-ld.enable = true;
  programs.kdeconnect.enable = true;
}
