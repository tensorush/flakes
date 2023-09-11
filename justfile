nrs HOST="utm":
    nixos-rebuild switch --flake .#{{HOST}}

tst HOST="utm":
    nixos-rebuild test --flake .#{{HOST}}

fmt:
    nix run nixpkgs#alejandra -- -c ./

unl:
    nix run nixpkgs#git-crypt unlock

upd:
    nix flake update

chk:
    nix flake check
