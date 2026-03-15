#!/usr/bin/env bash
# Script to add IDA Pro installer to nix store and update the hash
# Usage: ./scripts/update-ida-pro.sh /path/to/ida-pro_XX_x64linux.run

set -euo pipefail

INSTALLER_PATH="${1:-}"
PACKAGE_NIX="modules/overlays/ida-pro/packages/ida-pro.nix"

if [[ -z "$INSTALLER_PATH" ]]; then
    echo "Usage: $0 /path/to/ida-pro_XX_x64linux.run"
    echo ""
    echo "This script will:"
    echo "  1. Add the installer to the nix store"
    echo "  2. Calculate the SHA256 hash"
    echo "  3. Update the hash in $PACKAGE_NIX"
    exit 1
fi

if [[ ! -f "$INSTALLER_PATH" ]]; then
    echo "Error: File not found: $INSTALLER_PATH"
    exit 1
fi

FILENAME=$(basename "$INSTALLER_PATH")

# Extract version from filename (e.g., ida-pro_92_x64linux.run -> 9.2)
if [[ "$FILENAME" =~ ida-pro_([0-9])([0-9])_x64linux\.run ]]; then
    VERSION="${BASH_REMATCH[1]}.${BASH_REMATCH[2]}"
    echo "Detected IDA Pro version: $VERSION"
else
    echo "Error: Could not parse version from filename: $FILENAME"
    echo "Expected format: ida-pro_XX_x64linux.run (e.g., ida-pro_92_x64linux.run)"
    exit 1
fi

echo "Adding installer to nix store and calculating hash..."
# nix-prefetch-url adds to store and returns the hash that requireFile expects
HASH=$(nix-prefetch-url --type sha256 "file://$INSTALLER_PATH" --name "$FILENAME" 2>/dev/null)
echo "Hash (base32): $HASH"

# Convert to SRI format for the nix file
SRI_HASH=$(nix hash convert --to sri --hash-algo sha256 "$HASH")
echo "Hash (SRI):    $SRI_HASH"

echo "File added to nix store."

# Update the nix file
if [[ -f "$PACKAGE_NIX" ]]; then
    echo ""
    echo "Updating $PACKAGE_NIX..."

    # Update idaVersion
    sed -i "s/idaVersion ? \"[^\"]*\"/idaVersion ? \"$VERSION\"/" "$PACKAGE_NIX"

    # Update idaHash
    sed -i "s|idaHash ? \"sha256-[^\"]*\"|idaHash ? \"$SRI_HASH\"|" "$PACKAGE_NIX"

    echo "Updated package configuration."
else
    echo ""
    echo "Package file not found at $PACKAGE_NIX"
    echo "Please update manually with:"
    echo "  idaVersion = \"$VERSION\";"
    echo "  idaHash = \"$SRI_HASH\";"
fi

echo ""
echo "Done. You can now rebuild your NixOS configuration."
echo ""
echo "If nix complains about missing file, run:"
echo "  nix-store --add-fixed sha256 $INSTALLER_PATH"
