{
  pkgs,
  inputs,
  ...
}:

{
  nixpkgs.overlays = [
    (import ../../home/overlays/vmware.nix inputs)
  ];

  environment.systemPackages = with pkgs; [ vmware-workstation ];
  virtualisation = {
    vmware.host.enable = true;
  };

}
