{
  pkgs,
  lib,
  inputs,
  ...
}:
{
  nixpkgs.overlays = [
    (final: prev: {
      ida-pro = prev.callPackage ../../overlays/ida-pro/packages/ida-pro.nix { };
    })
    (_: prev: {
      pythonPackagesExtensions =
        (prev.pythonPackagesExtensions or [ ])
        ++ [
          (_: pyPrev: {
            construct-classes = pyPrev.construct-classes.overridePythonAttrs (old: {
              postPatch = (old.postPatch or "") + ''
                substituteInPlace pyproject.toml --replace-warn "uv_build>=0.8.13,<0.9.0" "uv_build>=0.8.13,<0.11.0"
                substituteInPlace pyproject.toml --replace-warn "uv_build>=0.8.13,<0.10.0" "uv_build>=0.8.13,<0.11.0"
              '';
            });
          })
        ];
    })
  ];

  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "ida-pro"
      "ida-pro-with-venv"
    ];

  home.packages = with pkgs; [
    (
      (
        inputs.binaryninja.packages.${pkgs.stdenv.hostPlatform.system}.binary-ninja-commercial-wayland.override
        {
          # overrideSource = /home/rick/labvz/binaryninja_linux_stable_commercial.zip;
          overrideSource = /home/rick/Downloads/binaryninja_linux_stable_personal.zip;
          python3 = pkgs.python312;
        }
      ).overrideAttrs
      (old: {
        buildInputs = (old.buildInputs or [ ]) ++ [ pkgs.sqlite ];
        autoPatchelfIgnoreMissingDeps = (old.autoPatchelfIgnoreMissingDeps or [ ]) ++ [
          "libQt6WaylandEglClientHwIntegration.so.6"
        ];
      })
    )

    # for binary ninja
    libglvnd # For libEGL

    (callPackage ../../packages/ida-pro-with-venv.nix {
      ida-pro-package = ida-pro;
    })
  ];
}
