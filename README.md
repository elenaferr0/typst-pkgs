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
Typst local packages are stored in this path `{data-dir}/typst/packages/{namespace}/{name}/{version}`, where `{data-dir}` depends on your OS. Find the corresponding path #[here](https://github.com/typst/packages?tab=readme-ov-file#local-packages).
To use any of the packages inside this repo you would simply need to place it in the right folder and then import it.

Get the right `{data-dir}` for your OS in the link above, then simply clone this repo in `{data-dir}/typst/packages`.
- `{namespace}` will, in this case, match my username (i.e. `elenaferr0`);
- `{name}` will be the package you want to use;
- `{version}` version of the package you want to use. Must of course match one of the existing directories.

You should be able to import the package with
```typst
#import "@elenaferr0/package-name:1.0.0": *
```
