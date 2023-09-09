apl-sys:
    nixos-rebuild switch --flake .#tensorush

apl-hmm:
    home-manager switch --flake .#tensorush

tst:
    nixos-rebuild test --flake .#tensorush

fmt:
    nix run nixpkgs#statix -- check ./

gen:
    nixos-generate-config

upd:
    nix flake update

chk:
    nix flake check
