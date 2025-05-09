inputs: final: prev:
let
  system = prev.stdenv.hostPlatform.system;
  pkgs-vmware-pinned = import inputs.vmware-pinned {
    inherit system;
    config = {
      allowUnfree = true;
    };
  };
in
{
  vmware-workstation = pkgs-vmware-pinned.vmware-workstation;
}
