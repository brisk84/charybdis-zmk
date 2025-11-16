#!/usr/bin/env bash

set -euxo pipefail

# Requirements:
# 1. https://zmk.dev/docs/development/setup (install west and dependencies)

CURRENT_DIR="$(pwd)"
CONFIG_DIR="$CURRENT_DIR/config"

# Initialize west workspace if not already initialized
if [ ! -d "$CURRENT_DIR/.west" ]; then
    echo "Initializing west workspace..."
    west init -l "$CONFIG_DIR"
    west update
    west zephyr-export
fi

build_and_copy () {
    local side=$1
    # Build with external modules support
    # ZEPHYR_MODULES tells CMake about workspace-level modules like zmk-pmw3610-driver
    # FORCED_CONF_FILE makes kconfig use --forced-input-configs flag, which treats warnings as non-fatal
    ZEPHYR_MODULES="$CURRENT_DIR/zmk-pmw3610-driver" \
    west build -p \
        -b nice_nano_v2 -- \
        -DSHIELD=charybdis_$side \
        -DZMK_CONFIG="$CONFIG_DIR" \
        -DBOARD_ROOT="$CURRENT_DIR" \
        -DFORCED_CONF_FILE="$CURRENT_DIR/forced.conf"

    cp "./build/zephyr/zmk.uf2" "$CURRENT_DIR/build/charybdis_$side.uf2"
}

mkdir -p "$CURRENT_DIR/build"

pushd "$CURRENT_DIR/zmk/app"

build_and_copy left
build_and_copy right

popd

echo ""
echo "Build complete! Firmware files:"
echo "  $CURRENT_DIR/build/charybdis_left.uf2"
echo "  $CURRENT_DIR/build/charybdis_right.uf2"
