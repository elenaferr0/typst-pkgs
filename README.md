# Custom Typst Packages
This repository contains a collection of custom packages for Typst, a modern markup-based typesetting system. These can be used locally within your projects.

# The Weird Package Structure
You might be wondering why on Earth someone would want to structure their repository this way. Why would someone create a directory with their username inside the repo and then proceed to create a sub-directory for every version of the package?
Well I didn't come up with it, this is just Typst way of handling packages, so you'll have to get over it.

```
elenaferr0/            # Namespace
  package-name/
  ├── typst.toml       # Package metadata
  ├── main.typ         # Main module file
  └── ...              # Additional files and directories
scripts/               # Utilities to manage pkgs
```

## Local setup
Typst local packages are stored in this path `{data-dir}/typst/packages/{namespace}/{name}/{version}`, where `{data-dir}` depends on your OS. Find the corresponding path [here](https://github.com/typst/packages?tab=readme-ov-file#local-packages).
To use any of the packages inside this repo you would simply need to place it in the right folder and then import it.

Get the right `{data-dir}` for your OS in the link above, then simply clone this repo in `{data-dir}/typst/packages`.
- `{namespace}` will, in this case, match my username (i.e. `elenaferr0`);
- `{name}` will be the package you want to use;
- `{version}` version of the package you want to use. Must of course match one of the existing directories.

You should be able to import the package with
```typst
#import "@elenaferr0/package-name:1.0.0": *
```
### Set up with Nix
I have been successfully using [Typix](https://github.com/loqusion/typix/) to build and watch my Typst documents with Nix. It allows you for instance to create a shell with all dependencies you might need (e.g. by downloading fonts).

A simple flake could be
```nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    typix = {
      url = "github:loqusion/typix/";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-utils.url = "github:numtide/flake-utils";

    typst-packages = {
      url = "github:typst/packages";
      flake = false;
    };

    typst-pkgs = { # fetches my own packages repo
      url = "github:elenaferr0/typst-pkgs";
      flake = false;
    };
  };

  outputs = inputs @ {
    nixpkgs,
    typix,
    flake-utils,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = nixpkgs.legacyPackages.${system};
      inherit (pkgs) lib;

      typixLib = typix.lib.${system};
      src = typixLib.cleanTypstSource ./.;

      commonArgs = {
        typstSource = "main.typ";

        fontPaths = [
          "${pkgs.ibm-plex}/share/fonts/opentype"
        ];

        virtualPaths = [
          # Add paths that must be locally accessible to typst here
          # {
          #   dest = "icons";
          #   src = "${inputs.font-awesome}/svgs/regular";
          # }
        ];
      };
      typstPackagesSrc = pkgs.symlinkJoin {
        name = "typst-packages-src";
        paths = [
          "${inputs.typst-packages}/packages"
          # Adding my custom package here, which will be automatically added to typst package cache
          "${inputs.typst-pkgs}"
        ];
      };
      typstPackagesCache = pkgs.stdenvNoCC.mkDerivation {
        name = "typst-packages-cache";
        src = typstPackagesSrc;
        dontBuild = true;
        installPhase = ''
          mkdir -p "$out/typst/packages"
          cp -LR --reflink=auto --no-preserve=mode -t "$out/typst/packages" "$src"/*
        '';
      };

      # Compile a Typst project, *without* copying the result
      # to the current directory
      build-drv = typixLib.buildTypstProject (commonArgs
        // {
          inherit src;
          XDG_CACHE_HOME = typstPackagesCache;
        });

      # Compile a Typst project, and then copy the result
      # to the current directory
      build-script = typixLib.buildTypstProjectLocal (commonArgs
        // {
          inherit src;
          XDG_CACHE_HOME = typstPackagesCache;
        });

      # Watch a project and recompile on changes
      watch-script = typixLib.watchTypstProject (commonArgs // {
        # If you're using custom packages (such as in this case) then you manually need to override the watch command to set XDG_CACHE_HOME
        typstWatchCommand = "XDG_CACHE_HOME=${typstPackagesCache} typst watch";
      });
    in {
      checks = {
        inherit build-drv build-script watch-script;
      };

      packages.default = build-drv;

      apps = rec {
        default = watch;
        build = flake-utils.lib.mkApp {
          drv = build-script;
        };
        watch = flake-utils.lib.mkApp {
          drv = watch-script;
        };
      };

      devShells.default = typixLib.devShell {
        inherit (commonArgs) fontPaths virtualPaths;
        packages = [
          # WARNING: Don't run `typst-build` directly, instead use `nix run .#build`
          # See https://github.com/loqusion/typix/issues/2
          # build-script
          watch-script
          # More packages can be added here, like typstfmt
          pkgs.typstfmt
        ];
      };
    });
}

```
