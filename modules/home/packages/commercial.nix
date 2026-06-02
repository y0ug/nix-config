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
          overrideSource = builtins.path {
            name = "binaryninja_linux_stable_personal.zip";
            path = ../../../installer/binaryninja_linux_stable_personal.zip;
            sha256 = "sha256-f4FxZFJzodqXcYozVhyEyvSb65qFwrxN/apKdwKzdx0=";
          };
          python3 = pkgs.python312;
        }
      ).overrideAttrs
      (old: {
        buildInputs = (old.buildInputs or [ ]) ++ [ pkgs.sqlite ];
        autoPatchelfIgnoreMissingDeps = (old.autoPatchelfIgnoreMissingDeps or [ ]) ++ [
          "libQt6WaylandEglClientHwIntegration.so.6"
        ];
        postInstall = (old.postInstall or "") + ''
          unzip -j "$src" 'binaryninja/libQt6*.so.6' 'binaryninja/libicu*.so.70' -d "$out/opt/binaryninja"
        '';
        postFixup = (old.postFixup or "") + ''
          rm "$out/bin/binaryninja"
          makeWrapper "$out/opt/binaryninja/binaryninja" "$out/bin/binaryninja" \
            --prefix PYTHONPATH : "${pkgs.python312Packages.pip}/${pkgs.python312.sitePackages}" \
            --set-default QT_QPA_PLATFORM wayland \
            --set QT_PLUGIN_PATH "$out/opt/binaryninja/qt" \
            --unset NIXPKGS_QT6_QML_IMPORT_PATH \
            --unset QML2_IMPORT_PATH
        '';
      })
    )

    # for binary ninja
    libglvnd # For libEGL

    (callPackage ../../packages/ida-pro-with-venv.nix {
      ida-pro-package = ida-pro;
    })
  ];
}
