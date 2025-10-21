{
  pkgs,
  lib,
  ida-pro-package,
}:

let
  # Helper script to manage the venv
  ida-pip-helper = pkgs.writeShellScriptBin "ida-pip" ''
    VENV_DIR="$HOME/.local/share/ida-pro/venv"

    if [ ! -d "$VENV_DIR" ]; then
      echo "Error: IDA Python venv not initialized. Run ida64 first."
      exit 1
    fi

    exec "$VENV_DIR/bin/pip" "$@"
  '';

  # Helper script to activate the venv in a shell
  ida-venv-activate = pkgs.writeShellScriptBin "ida-venv" ''
    VENV_DIR="$HOME/.local/share/ida-pro/venv"

    if [ ! -d "$VENV_DIR" ]; then
      echo "Error: IDA Python venv not initialized. Run ida64 first."
      exit 1
    fi

    echo "Activating IDA Python venv..."
    echo "Use 'deactivate' to exit the venv."
    exec bash --rcfile <(cat <<'RCFILE'
source "$HOME/.bashrc" 2>/dev/null || true
source "$HOME/.local/share/ida-pro/venv/bin/activate"
RCFILE
)
  '';

  # Wrapper for ida64
  ida64-wrapped = pkgs.writeShellScriptBin "ida64" ''
    VENV_DIR="$HOME/.local/share/ida-pro/venv"

    # Create venv if it doesn't exist
    if [ ! -d "$VENV_DIR" ]; then
      echo "Creating Python virtual environment for IDA Pro..."
      ${pkgs.python313}/bin/python -m venv "$VENV_DIR"
      echo "Installing pip..."
      "$VENV_DIR/bin/pip" install --upgrade pip
      echo ""
      echo "✓ IDA Python environment created at $VENV_DIR"
      echo "  Install packages with: ida-pip install <package>"
      echo ""
    fi

    # Add venv packages to PYTHONPATH (expand glob)
    for dir in "$VENV_DIR"/lib/python*/site-packages; do
      if [ -d "$dir" ]; then
        export PYTHONPATH="$dir:$PYTHONPATH"
        break
      fi
    done

    # Run actual IDA
    exec ${ida-pro-package}/bin/ida64 "$@"
  '';

  # Wrapper for ida (32-bit, if needed)
  ida-wrapped = pkgs.writeShellScriptBin "ida" ''
    VENV_DIR="$HOME/.local/share/ida-pro/venv"

    if [ ! -d "$VENV_DIR" ]; then
      echo "Creating Python virtual environment for IDA Pro..."
      ${pkgs.python313}/bin/python -m venv "$VENV_DIR"
      "$VENV_DIR/bin/pip" install --upgrade pip
    fi

    # Add venv packages to PYTHONPATH (expand glob)
    for dir in "$VENV_DIR"/lib/python*/site-packages; do
      if [ -d "$dir" ]; then
        export PYTHONPATH="$dir:$PYTHONPATH"
        break
      fi
    done
    exec ${ida-pro-package}/bin/ida "$@"
  '';

in
pkgs.symlinkJoin {
  name = "ida-pro-with-venv";
  paths = [
    ida64-wrapped
    ida-wrapped
    ida-pip-helper
    ida-venv-activate
    ida-pro-package
  ];

  meta = ida-pro-package.meta // {
    description = "${ida-pro-package.meta.description or "IDA Pro"} (with venv support)";
  };
}
