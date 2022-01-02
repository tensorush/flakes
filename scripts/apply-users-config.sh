#!/bin/sh
pushd ~/My-NixOS-Configuration
nix build .#homeManagerConfigurations.zhora.activationPackage
./result/activate
popd
