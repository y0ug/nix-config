{ ... }:
[
  (final: prev: {
    ida-pro = prev.callPackage ./ida-pro/packages/ida-pro.nix { };
  })
]
