# Package status

Which packages have been built, installed and tested on real (emulated)
OPENSTEP, and where.  "validated" means the package built, installed and its
`test` hook passed.  "—" means no result has been recorded, not that it fails.

Last updated 2026-10-06.  Results come from test runs on the x86 and SPARC
OPENSTEP 4.2 machines; most packages have only been tried on x86 so far.  M68k
has not been attempted.

**x86, 2026-10-08:** a rebootstrap on a fresh host built, installed and tested
all 93 packages in the tree, including the October 2026 security fixes (bzip2,
freetype, libmad, wget, gzip, zip, patch, tar, openssl, emacs, lha) and the
version bumps (mpg123 1.33.7, ca-certificates 2026.09.25, expat 2.9.0, libpng
1.6.59, python311 3.11.17, vim 9.2.1091).  vim needed seven build fixes for the
9.2.1091 bump (`wait()` in `osdef.h`, int `W*()` macros, no `<sys/utsname.h>`, no
`<utime.h>`, `FD_CLOEXEC`, `struct sockaddr_storage`, and `tcgetattr`/`tcsetattr`
from the BSD ioctls).  The tables below show earlier results.  SPARC is being
rebuilt from scratch in dependency order; bash, curl and gcc42 are done there, and
the October 2026 security fixes have not been tested on SPARC.  pkg itself gained a
retry through `tarfix` for tarballs whose uid/gid exceed OPENSTEP's 16-bit uid_t.

lha is only partly hardened: upstream's 2016 header and symlink fixes are ported
to 1.14i-ac20050924p1, but two header-read gaps upstream also left are not
fixed.  Use it for old, known-safe archives only.

| Package | x86 | SPARC |
|---|---|---|
| bash | validated | validated (rebuilt on the rebootstrapped host) |
| bison | validated | validated |
| bzip2 | validated | validated |
| ca-certificates | validated | validated |
| cctools-as | 806 validated | — |
| class-dump | validated | — |
| coreutils | validated | validated (with pkg_cmp_shim) |
| curl | validated | validated (rebuilt on the rebootstrapped host, after the bash fix) |
| diffutils | validated | — |
| duktape | validated | — |
| emacs | validated | — |
| expat | validated | validated |
| ffmpeg | validated | — |
| findutils | validated | validated |
| flex | validated | validated |
| freetype | validated | — |
| freeze | validated | validated |
| fribidi | 0.19.7 validated | — |
| gawk | validated | validated (with pkg_cmp_shim) |
| gcc42 | validated | validated (port; bootstraps, compare passes, `pkg test` passes; clean rebuild on a rebootstrapped host, 2026-10-08) |
| git | validated | validated (2.55.0; needs the unsigned memcmp/strcmp fix and -O0) |
| gperf | validated | — |
| grep | validated | validated (with pkg_cmp_shim) |
| gzip | validated | — |
| help2man | validated | validated |
| jpeg | validated | — |
| less | validated | — |
| lha | validated | — |
| liba52 | validated | — |
| libcss | validated | — |
| libdom | validated | — |
| libgcrypt | 1.5.6 validated | — |
| libgpg-error | 1.12 validated | — |
| libhubbub | validated | — |
| libiconv | validated | validated |
| libmad | validated | — |
| libmpeg2 | validated | — |
| libnsbmp | validated | — |
| libnsfb | validated | — |
| libnsgif | validated | — |
| libnslog | validated | — |
| libnsutils | validated | — |
| libparserutils | validated | — |
| libpng | validated | validated |
| libsvgtiny | validated | — |
| libwapcaplet | validated | — |
| libxml2 | validated on x86 (2.15.4: build, install, test) | — |
| lua | validated | — |
| lua51 | 5.1.5 validated | — |
| lz4 | validated | — |
| m4 | validated | validated |
| make | validated (built with the system cc) | validated (built with the system cc) |
| mktemp | validated | validated |
| mpg123 | validated (1.33.7, with private stdint.h/inttypes.h shims; rebuilt on a fresh host) | — |
| nano | validated | validated |
| ncurses | validated | validated |
| nethack | validated (tty and X11) | — |
| netsurf-buildsystem | validated | — |
| neXtaw | validated | — |
| nsgenbind | validated | — |
| ntp | validated (build, install, test; ntpdate and ntpd run against a server); on a fresh host configure's `setrlimit` check failed (prototype clash with `<sys/resource.h>`), so `ntp/build` supplies a no-op `ntp_rlimit()` (x86 rebuilt with it); `rc.ntp` boot script tested on Linux only | — |
| openssh | validated (10.6p1: sshd, ssh login by password and key, scp); `rc.sshd` boot script tested on Linux only | 10.6p1 untested (7.9p1 was validated) |
| openssl | validated | validated |
| p7zip | validated | — |
| patch | validated | validated |
| pdksh | validated | validated |
| perl | validated | validated |
| pkgconf | validated on x86 (3.0.7: build, install, test; replaces pkg-config 0.29) | — |
| python311 | validated | — |
| quake2 | validated (content-free dedicated-server startup test; no game data) | — |
| quickjs | validated | — |
| roboclient | 1.0 validated; 1.1 adds `rc.dhcp` (tested on Linux, not yet on OPENSTEP) | — |
| rsync | validated | — |
| sdl12 | validated | — |
| sed | validated | validated (with pkg_cmp_shim) |
| sudo | validated | — |
| tar | 1.15.1 validated | — |
| tcsh | validated | — |
| termcap | validated | — |
| texinfo | validated | validated |
| top | validated | validated |
| unzip | validated | validated |
| utf8proc | validated | — |
| vim | validated | validated |
| vlc | 0.9.10 validated (runs as root) | — |
| wget | 1.25.0 validated on x86 (HTTPS via OpenSSL; SPARC untested) | 1.25.0 untested |
| wget-bootstrap | 1.19.5 validated | 1.19.5 validated (needs the localtime and unsigned-compare fixes) |
| xxhash | validated (manual build, after replacing `ln -sf`; rebuilt on a fresh host) | validated (`XXH_FORCE_MEMORY_ACCESS=0`: the default packed-union reads bus-error with gcc 4.2; compiling `xxhash.c` is very slow) |
| xz | validated | validated |
| zip | validated | — |
| zlib | validated | validated |
| zsh | validated | validated |
| zstd | validated | — |

## Notes

- **sudo** is 1.7.10p9, not a current release.  1.8 and later need `siginfo_t`,
  `SA_SIGINFO` and `struct timespec`, which OPENSTEP lacks.  The package patches
  CVE-2021-3156 (Baron Samedit), CVE-2019-14287 (`-u#-1`) and CVE-2019-18634
  (`pwfeedback` overflow); other known issues remain (see `sudo/` patch comments),
  so do not expose a machine running it.  I/O logging (`log_output`) and
  `sudoreplay` are built (with zlib), but the `log_output` path has only been
  checked by compiling, not exercised.
- **tar** (1.15.1, upstream's) installs `/usr/local/bin/gnutar`; `pkg` prefers it for unpacking sources and for xz/zstd/bzip2 archives. It never replaces the system `tar`.
- **termcap** never installs `/etc/termcap`.
- **bash** is 5.3, built with `-DGETCWD_BROKEN` and a compat patch for
  `waitpid`, `tcgetattr` and friends.
- **perl** (5.8.9) on SPARC is waiting on a first full build.
- **ntp** is 4.2.8p18 (ntpsec needs pthreads, which OPENSTEP lacks); `ntpd`
  installs into `sbin` and a default `ntpd.conf` is copied into place only if
  none exists.
- A failed build can be resumed with `PKG_RESUME=1` (see `README.md`).
- **git** on SPARC builds at `-O0` and uses unsigned `memcmp`/`strcmp`/`strncmp`
  replacements: the SPARC libc compares bytes as signed, which corrupted pack
  indexes.  Packages that rely on byte-order comparisons use `pkg_cmp_shim`
  (see `README.md`); their SPARC rebuilds are still pending.
