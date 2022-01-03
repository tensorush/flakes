#!/bin/sh
pushd ~/My-NixOS-Flake
nix build .#homeManagerConfigurations.zhora.activationPackage
./result/activate
popd
