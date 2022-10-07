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
        packages.default = auto-changelog;

        devShells = {
          default = pkgs.mkShellNoCC {
            name = "auto-changelog";

            buildInputs = [
              auto-changelog
            ];
          };

          dev = pkgs.mkShell {
            name = "auto-changelog-dev";

            buildInputs = [
              auto-changelog
              pkgs.nixpkgs-fmt
              pkgs.nixfmt
            ];
          };
        };
      }
    );

}
