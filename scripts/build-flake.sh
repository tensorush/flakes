#!/bin/sh
pushd ~/My-NixOS-Flake
nixos-rebuild build --flake .#
popd
