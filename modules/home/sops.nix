{ inputs, config, ... }:
{
  imports = [ inputs.sops-nix.homeManagerModules.sops ];

  sops = {
    defaultSopsFile = ../../secrets/secrets.yaml;
    age.keyFile = "/home/rick/.config/sops/age/keys.txt";

    secrets.goprivate = {};
  };

  home.sessionVariablesExtra = ''
    export GOPRIVATE="$(cat ${config.sops.secrets.goprivate.path})"
  '';
}
