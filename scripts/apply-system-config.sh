#!/bin/sh
pushd ~/My-NixOS-Flake
sudo nixos-rebuild switch --flake .#
popd
