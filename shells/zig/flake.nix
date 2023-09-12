{
  description = "Zig compiler development shell.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {inherit system;};
      in {
        devShells.default = pkgs.mkShell {
          nativeBuildInputs = with pkgs;
            [
              zig
              zls
              zlib
              cmake
              ninja
              libxml2
              wasmtime
            ]
            ++ (with llvmPackages_16; [
              lld
              llvm
              clang
            ]);
          hardeningDisable = ["all"];
          shellHook = ''
            echo "zig `${pkgs.zig}/zig --version`"
            exec nu
          '';
        };
      }
    );
}
