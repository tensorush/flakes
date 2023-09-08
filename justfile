apl-flk:
    nixos-rebuild switch --flake ".#tensorush"

tst-flk:
    nixos-rebuild test --flake ".#tensorush"

upd-flk:
    nix flake update
