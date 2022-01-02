#!/bin/sh
pushd ~/My-NixOS-Configuration
sudo nixos-rebuild switch --flake .#
popd
