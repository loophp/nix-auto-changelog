{
  description = "Nix Auto Changelog";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, flake-utils, nixpkgs }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config = { allowUnfree = true; };
        };
      in
      {
        packages.default = pkgs.nodePackages.auto-changelog;

        devShells = {
          default = pkgs.mkShellNoCC {
            name = "auto-changelog";

            buildInputs = [
              pkgs.nodePackages.auto-changelog
            ];
          };

          dev = pkgs.mkShell {
            name = "auto-changelog-dev";

            buildInputs = [
              pkgs.nodePackages.auto-changelog
              pkgs.nixpkgs-fmt
              pkgs.nixfmt
            ];
          };
        };
      }
    );

}
