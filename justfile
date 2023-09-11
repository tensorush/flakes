nrs HOST="utm-aarch64":
    nixos-rebuild switch --flake .#{{HOST}}

tst HOST="utm-aarch64":
    nixos-rebuild test --flake .#{{HOST}}

fmt:
    nix run nixpkgs#alejandra -- -c ./

unl:
    nix run nixpkgs#git-crypt unlock

gen:
    nixos-generate-config

upd:
    nix flake update

chk:
    nix flake check
