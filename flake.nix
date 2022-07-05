{
  description = "Nix Auto Changelog";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    flake-utils.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, flake-utils, nixpkgs }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config = { allowUnfree = true; };
        };

        auto-changelog = pkgs.mkYarnPackage {
          name = "auto-changelog";
          src = ./.;
          packageJSON = ./package.json;
          yarnLock = ./yarn.lock;
          yarnNix = ./yarn.nix;
          publishBinsFor = [
            "auto-changelog"
          ];
          # TODO: Find a way to get rid of that line.
          postInstall = "ln -s $out/libexec/nix-auto-changelog/node_modules/.bin/auto-changelog $out/bin/nix-auto-changelog";
        };

      in
      {
        packages = flake-utils.lib.flattenTree {
          default = auto-changelog;
        };

        devShells = {
          default = pkgs.mkShell {
            name = "auto-changelog";

            buildInputs = [
              self.packages.${system}.default
            ];
          };

          dev = pkgs.mkShell {
            name = "auto-changelog-dev";

            buildInputs = [
              self.packages.${system}.default
              pkgs.nixpkgs-fmt
              pkgs.nixfmt
            ];
          };
        };
      }
    );

}
