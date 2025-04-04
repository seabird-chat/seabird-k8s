{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs =
    inputs@{
      self,
      flake-parts,
      ...
    }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
        "aarch64-darwin"
      ];
      perSystem =
        {
          pkgs,
          config,
          system,
          lib,
          ...
        }:
        {
          formatter = pkgs.nixfmt-rfc-style;

          devShells.default = pkgs.mkShell {
            packages = with pkgs;
            with config.packages; [

                flux-bin
                talhelper-bin
                talosctl-bin

                age
                kubernetes-helm
                sops
            ];
          };

          packages = lib.packagesFromDirectoryRecursive {
            callPackage = pkgs.callPackage;
            directory = ./nix/pkgs;
          };
        };
    };
}
