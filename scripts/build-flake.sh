#!/bin/sh
pushd ~/My-NixOS-Configuration
nixos-rebuild build --flake .#
popd
