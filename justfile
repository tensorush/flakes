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

upd-shl:
    for dir in `ls shells`; do \
        cd shells/$dir && just upd; \
    done

chk:
    nix flake check
