{
  pkgs ? import <nixpkgs> { },
}:

let
  # # Create a Python environment with custom packages
  # customPython = pkgs.python312.withPackages (
  #   ps: with ps; [
  #     google-api-core
  #     google-auth
  #     google-cloud-core
  #     googleapis-common-protos
  #     google-generativeai
  #   ]
  # );

  # Override aider-chat to include our dependencies
  customAider = pkgs.aider-chat.overridePythonAttrs (oldAttrs: {
    dependencies = oldAttrs.dependencies ++ [
      pkgs.python3Packages.google-api-core
      pkgs.python3Packages.google-auth
      pkgs.python3Packages.google-cloud-core
      pkgs.python3Packages.googleapis-common-protos
      pkgs.python3Packages.google-generativeai
    ];
  });
in
pkgs.mkShell {
  buildInputs = [
    # customPython
    customAider
  ];

  # Debug environment variables
  shellHook = ''
        echo "Python path: $(which python)"
        echo "Aider path: $(which aider)"
        
        # Set up Python path to include our custom packages
        
        # Create a simple test script
        cat > test_imports.py << 'EOF'
    import sys
    print("Python version:", sys.version)
    print("Python path:", sys.path)

    try:
        import google.generativeai
        print("Successfully imported google.generativeai")
    except ImportError as e:
        print("Failed to import:", e)

    try:
        import litellm
        print("Successfully imported litellm")
    except ImportError as e:
        print("Failed to import:", e)
    EOF
        
        echo "Run 'python test_imports.py' to test imports"
        echo "Run 'aider' to test the application"
  '';
}
