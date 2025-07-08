{ pkgs, lib, ... }:

let
  # Create a wrapper script for Python with libmagic
  pythonWithMagicWrapper = pkgs.writeScriptBin "python-with-magic" ''
    #!/bin/sh
    export PYTHONPATH=${pkgs.python3Packages.python-magic}/${pkgs.python3.sitePackages}:$PYTHONPATH
    export MAGIC=${pkgs.file}/share/misc/magic.mgc
    export MAGICFILE=${pkgs.file}/share/misc/magic.mgc
    export LD_LIBRARY_PATH=${pkgs.file}/lib:$LD_LIBRARY_PATH
    exec ${pkgs.python3}/bin/python "$@"
  '';
  
  # Create a Python environment with libmagic
  pythonWithMagic = pkgs.python3.withPackages (ps: with ps; [
    pip
    setuptools
    wheel
    python-magic
  ]);
in
{
  # Make Python with libmagic available system-wide
  environment.systemPackages = with pkgs; [
    # The standard Python interpreter
    python3
    
    # Python interpreter with python-magic pre-installed
    pythonWithMagic
    
    # Our wrapper script
    pythonWithMagicWrapper
    
    # Make sure libmagic is available
    file
    
    # Include the Python magic module directly
    python3Packages.python-magic
  ];

  # Set environment variables to help all Python installations find libmagic
  environment.variables = {
    # Point to the libmagic database in the Nix store
    MAGIC = "${pkgs.file}/share/misc/magic.mgc";
    MAGICFILE = "${pkgs.file}/share/misc/magic.mgc";
  };
  
  # Create a simple script that users can source to set up their environment
  environment.etc."pythonmagic.sh" = {
    text = ''
      # Source this file to set up Python with libmagic
      export PYTHONPATH=${pkgs.python3Packages.python-magic}/${pkgs.python3.sitePackages}:$PYTHONPATH
      export MAGIC=${pkgs.file}/share/misc/magic.mgc
      export MAGICFILE=${pkgs.file}/share/misc/magic.mgc
      export LD_LIBRARY_PATH=${pkgs.file}/lib:$LD_LIBRARY_PATH
      echo "Environment set up for Python with libmagic"
    '';
    mode = "0644";
  };
}