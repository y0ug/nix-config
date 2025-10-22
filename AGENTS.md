# Repo Overview

## Layout
- `flake.nix` ties inputs to outputs and imports overlays from `modules/overlays/default.nix`. Outputs cover the two NixOS hosts, the macOS host, and the remaining Home Manager profiles.
- `hosts/<name>/configuration.nix` provides host-specific logic; common Linux bits flow from `modules/core/workstation.nix` (which chains into `system.nix`, `nix-settings.nix`, tooling modules, and `gui/`).
- `modules/core/` holds reusable NixOS modules. `gui/` autodiscovers its children, and `workstation.nix` bundles the desktop stack. Keep new modules lower-case and pull shared nix config from `nix-settings.nix`.
- `modules/home/` collects Home Manager pieces that we plan to retire; `xdg/default-apps.nix` now centralises MIME defaults so they can migrate to system modules later.
- `modules/overlays/` contains the overlay list (`default.nix`) plus individual overlays like `custom-packages.nix` and the vendored `ida-pro` flake.
- `home/*.nix` are thin entrypoints that import the shared modules; `culixa.nix` now just wires profiles and host-specific tweaks.

## Commands
- `nix flake check` to validate evaluations.
- `nixos-rebuild switch --flake .#culixa` / `.#nixos-vm` and `darwin-rebuild switch --flake .#levua` for deployments.
- `home-manager switch --flake .#linux64-rick` / `.#osx-rick` while Home Manager still ships.
- Prefer `nix build .#<output>` for dry runs (e.g., `.#nixosConfigurations.culixa.config.system.build.toplevel`).

## Style & Naming
- Two-space indentation, braces on their own line, trailing commas.
- Lowercase attribute/module names; group options by subsystem.
- Add new shared logic under `modules/core` or `modules/home`; fall back to host overrides only when necessary.

## Testing & Workflow
- Run `nix flake check` before pushing; build touched derivations when feasible.
- For risky changes, use `*-rebuild test` or a disposable `switch` first.
- Document overlay bumps or cert rotations with provenance in PRs.
