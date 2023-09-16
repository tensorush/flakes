nrs HOST="utm":
    sudo nixos-rebuild switch --flake .#{{HOST}}

tst HOST="utm":
    nixos-rebuild test --flake .#{{HOST}}

fmt:
    nix run nixpkgs#alejandra -- -c ./

unl:
    nix run nixpkgs#git-crypt unlock

upd:
    nix flake update

upd-shls:
    for dir in `ls shells`; do \
        cd shells/$dir && nix flake update; \
    done

chk:
    nix flake check
