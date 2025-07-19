#!/bin/sh
# Fetch Theos dependencies (SDKs and toolchain) for building
set -e

THEOS_DIR="$(dirname "$0")/theos"
SDK_ARCHIVE_URL="https://github.com/theos/sdks/archive/refs/heads/master.tar.gz"
TOOLCHAIN_URL="https://github.com/L1ghtmann/llvm-project/releases/latest/download/iOSToolchain-$(uname -m).tar.xz"

mkdir -p "$THEOS_DIR"

# Ensure vendor components are present
if [ -d "$THEOS_DIR/.git" ]; then
    git -C "$THEOS_DIR" submodule update --init --recursive
fi

# Install SDKs if missing
if ! ls "$THEOS_DIR"/sdks/*.sdk >/dev/null 2>&1; then
    echo "Downloading iOS SDKs..."
    tmpdir=$(mktemp -d)
    curl -L "$SDK_ARCHIVE_URL" | tar -xz -C "$tmpdir"
    mkdir -p "$THEOS_DIR/sdks"
    cp -r "$tmpdir"/sdks-*/* "$THEOS_DIR/sdks/"
    rm -rf "$tmpdir"
fi

# Install toolchain if missing
if [ ! -x "$THEOS_DIR/toolchain/linux/iphone/bin/clang" ]; then
    echo "Downloading iOS toolchain..."
    mkdir -p "$THEOS_DIR/toolchain"
    curl -L "$TOOLCHAIN_URL" | tar -xJ -C "$THEOS_DIR/toolchain"
fi

echo "Theos dependencies are set up."
