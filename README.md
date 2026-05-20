# `pkg`

A minimal package manager for OPENSTEP.

## Usage

```sh
sh ./pkg download bash
sh ./pkg build bash
sh ./pkg install bash
sh ./pkg install bash grep
sh ./pkg test bash
sh ./pkg list
sh ./pkg remove bash
```

## Package layout

Each package is a directory named after the package:

```text
bash/
  build
  version
  depends
  sources
  post-install
  pre-remove
  test
```

Required:

- `build`
- `version`

Optional:

- `depends`
- `sources`
- `post-install`
- `pre-remove`
- `test`

## `version`

Contains the package version as a single field.

Example:

```text
3.2.57
```

## `sources`

One source per line. Blank lines and `#` comments are ignored.

Examples:

```text
https://ftp.gnu.org/gnu/bash/bash-3.2.57.tar.gz
bash-3.2.57-openstep.patch
files/site.h patches
```

Rules:

- remote URLs are downloaded into the source cache
- local paths are copied from the package directory
- `.tar.gz`, `.tgz`, and `.tar` archives are extracted into the build root
- non-archive files are copied as plain files
- `.tar.bz2`, `.tbz2`, `.tar.xz`, and `.txz` are rejected

The optional second field is the destination directory inside the build root.

## `depends`

Optional file with one package name per line.
Prefix a package name with `!` to declare a conflicting package that must not be installed.

Example:

```text
make
grep
!gcc33
```

Behavior:

- `pkg build` checks them before building
- `pkg build` requires positive dependencies to already be installed
- `pkg build` requires negative dependencies to be absent
- `pkg install` installs missing dependencies automatically when their package directories can be found alongside the requested package
- `pkg install` fails if a negative dependency is already installed
- `pkg install` accepts multiple package directories and installs them in the order provided
- no build-vs-runtime distinction

## `build`

`build` is run with:

- current directory set to the extracted source root when possible
- `$1` set to `DESTDIR`
- `$2` set to the package version
- `DESTDIR` exported in the environment
- `PKG_BUILD_HELPERS` exported as the path to `build-helpers.sh`
- `/usr/local/bin/ksh` used as the build shell for normal packages when
  available; the bootstrap `pdksh` package is built with `/bin/sh`

Example:

```sh
#!/bin/sh

set -e

DESTDIR=$1

. "$PKG_BUILD_HELPERS"
run_configure --prefix=/usr/local
gnumake
gnumake install DESTDIR="$DESTDIR"
```

## `test`

`test` is an optional `/bin/sh` script that validates the installed package.

- `sh ./pkg test <name>` runs the installed copy from `/usr/local/var/pkg/db/installed/<name>/test`
- the package must already be installed
- `PKG_NAME`, `PKG_VERSION`, `ROOT_DIR`, and `LOCAL_ROOT` are exported for the script
- `PATH` is prefixed with `$LOCAL_ROOT/bin:$LOCAL_ROOT/sbin`

## Install database

Installed packages are tracked under:

```text
/usr/local/var/pkg/db/installed
```

The default cache/staging area is:

```text
/usr/local/var/pkg/cache
```

After a successful `pkg build`, the download cache and unpacked build tree
under:

```text
/usr/local/var/pkg/cache/sources/<name>
/usr/local/var/pkg/cache/build/<name>
```

are removed automatically to save space.

The staged install image under:

```text
/usr/local/var/pkg/cache/pkg/<name>
```

is kept so a later `pkg install` can reuse it without rebuilding.

After a successful `pkg install`, that staged install image is also removed,
so no per-package cache remains.

If a package ships a `test` script, `pkg install` copies it into the installed
package database so `pkg test <name>` can validate the installed files later.

This layout assumes `/usr/local` is writable by the installing user. That lets
non-root users build and install packages into the shared `/usr/local` tree.

Paths can still be overridden with:

- `PKG_ROOT`
- `PKG_DB`
- `PKG_CACHE`
