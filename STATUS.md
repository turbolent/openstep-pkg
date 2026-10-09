# Package status

Which packages have been built, installed and tested on real (emulated)
OPENSTEP, and where.  "validated" means the package built, installed and its
`test` hook passed.  "—" means no result has been recorded, not that it fails.

Last updated 2026-10-06.  Results come from test runs on the x86 and SPARC
OPENSTEP 4.2 machines; most packages have only been tried on x86 so far.  M68k
has not been attempted.

**x86, 2026-10-08:** a rebootstrap on a fresh host built, installed and tested
all 93 packages in the tree, including the October 2026 security fixes (bzip2,
freetype, libmad, wget, gzip, zip, patch, tar, openssl, emacs) and the
version bumps (mpg123 1.33.7, ca-certificates 2026.09.25, expat 2.9.0, libpng
1.6.59, python311 3.11.17, vim 9.2.1091).  vim needed seven build fixes for the
9.2.1091 bump (`wait()` in `osdef.h`, int `W*()` macros, no `<sys/utsname.h>`, no
`<utime.h>`, `FD_CLOEXEC`, `struct sockaddr_storage`, and `tcgetattr`/`tcsetattr`
from the BSD ioctls).  The tables below show earlier results.  SPARC is being
rebuilt from scratch in dependency order (2026-10-08): so far the packages marked "rebootstrap, 2026-10-08" below have been
rebuilt, installed and tested there, including bash, curl, gcc42, tar, patch,
python311, expat and ca-certificates; openssl, vim, openssh and the rest are still
to come.  The October 2026 security fixes are only partly covered on SPARC.  pkg itself gained a
retry through `tarfix` for tarballs whose uid/gid exceed OPENSTEP's 16-bit uid_t.

lha was removed from the tree (October 2026): its test failed on x86 even unpatched on the
rebootstrapped host (`lha a` of a directory adds only the directory entry), and p7zip can
extract .lzh/.lha archives.  It can be put back from git history (the last version was
1.14i-ac20050924p1 with a hand-ported security patch).

In the SPARC column, the number after "validated" is the package version that
was tested (taken from the tree at the commit that recorded the result).  "tree
is now X" means the package has since been bumped and the result no longer
covers it.  A matching version does not cover the October 2026 security
patches, which changed some packages without bumping them: of the SPARC rows
below, openssl still needs a rebuild to pick those up (bzip2, gzip, patch and
tar have been rebuilt; wget, zip and mpg123 have no SPARC result).

| Package | x86 | SPARC |
|---|---|---|
| bash | validated | validated 5.3 (rebuilt on the rebootstrapped host) |
| bison | validated | validated 2.4.3 (rebootstrap, 2026-10-08) |
| bzip2 | validated | validated 1.0.8 (rebootstrap, 2026-10-08) |
| ca-certificates | validated | validated 2026.09.25 (rebootstrap, 2026-10-08) |
| cctools-as | 806 validated | — |
| class-dump | validated | — |
| coreutils | validated (rebuilt on a host with libiconv installed, iconv off, 2026-10-09) | validated 5.0 (rebuilt with the unsigned memcmp via pkg_cmp_obj, 2026-10-08) |
| curl | validated | validated 8.17.0 (rebuilt on the rebootstrapped host, after the bash fix) |
| diffutils | validated | — |
| duktape | validated | — |
| emacs | validated | — |
| expat | validated | validated 2.9.0 (rebootstrap, 2026-10-08) |
| ffmpeg | validated | — |
| findutils | validated | validated 4.2.33 |
| flex | validated | validated 2.5.39 (rebootstrap, 2026-10-08) |
| freetype | validated | — |
| freeze | validated | validated 2.5 (rebootstrap, 2026-10-08) |
| fribidi | 0.19.7 validated | — |
| gawk | validated | validated 3.1.8 (rebuilt with the unsigned memcmp via pkg_cmp_obj, 2026-10-08) |
| gcc42 | validated | validated 4.2.1-apple-5666.3 (port; bootstraps, compare passes, `pkg test` passes; clean rebuild on a rebootstrapped host, 2026-10-08) |
| git | validated | validated 2.55.0 (needs the unsigned memcmp/strcmp fix and -O0) |
| gperf | validated | — |
| grep | validated | validated 2.5.4 (rebuilt with the unsigned memcmp via pkg_cmp_obj, 2026-10-08) |
| gzip | validated | validated 1.3.12 (rebootstrap, 2026-10-08) |
| help2man | validated | validated 1.27 |
| jpeg | validated | validated 8d (rebootstrap, 2026-10-08) |
| less | validated | validated 710 (rebootstrap, 2026-10-08) |
| liba52 | validated | validated 0.7.4 (rebootstrap, 2026-10-08) |
| libcss | validated | — |
| libdom | validated | — |
| libgcrypt | 1.5.6 validated | — |
| libgpg-error | 1.12 validated | — |
| libhubbub | validated | — |
| libiconv | validated | validated 1.15 (rebootstrap, 2026-10-08) |
| libmad | validated | — |
| libmpeg2 | validated | — |
| libnsbmp | validated | — |
| libnsfb | validated | — |
| libnsgif | validated | — |
| libnslog | validated | — |
| libnsutils | validated | — |
| libparserutils | validated | validated 0.2.5 (rebootstrap, 2026-10-08) |
| libpng | validated | validated 1.6.58 (tree is now 1.6.59: needs retest) |
| libsvgtiny | validated | — |
| libwapcaplet | validated | validated 0.4.3 (rebootstrap, 2026-10-08) |
| libxml2 | validated on x86 (2.15.4: build, install, test) | — |
| lua | validated | — |
| lua51 | 5.1.5 validated | — |
| lz4 | validated | — |
| m4 | validated | validated 1.4.6 (rebootstrap, 2026-10-08) |
| make | validated (built with the system cc) | validated 3.81 (built with the system cc; rebootstrap, 2026-10-08) |
| mktemp | validated | validated 1.7 (rebootstrap, 2026-10-08) |
| mpg123 | validated (1.33.7, with private stdint.h/inttypes.h shims; rebuilt on a fresh host) | — |
| nano | validated | validated 2.9.8 |
| ncurses | validated | validated 6.5 (rebootstrap, 2026-10-08) |
| nethack | validated (tty and X11) | validated 3.6.7 (`pkg test` passes, game starts; a stray "pkg: Stock: not found" after the install was a script replaced mid-run, fixed in pkg; rebootstrap, 2026-10-08) |
| netsurf-buildsystem | validated | validated 1.10 (rebootstrap, 2026-10-08) |
| neXtaw | validated | — |
| nsgenbind | validated | — |
| ntp | validated (build, install, test; ntpdate and ntpd run against a server); on a fresh host configure's `setrlimit` check failed (prototype clash with `<sys/resource.h>`), so `ntp/build` supplies a no-op `ntp_rlimit()` (x86 rebuilt with it); `rc.ntp` boot script tested on Linux only | — |
| openssh | validated (10.6p1: sshd, ssh login by password and key, scp); `rc.sshd` boot script tested on Linux only | 10.6p1 untested (7.9p1 was validated) |
| openssl | validated | 1.1.1w FAILS on SPARC: OID lookups by DER (SHA1, AES, SHA-2, secp384r1 and others) fail because libcrypto used the signed libc memcmp; fixed in the build (pkg_cmp_named), not yet rebuilt |
| p7zip | validated | — |
| patch | validated | validated 2.6.1 (rebootstrap, 2026-10-08) |
| pdksh | validated | validated 5.2.14 (rebootstrap, 2026-10-08) |
| perl | validated | validated 5.8.9 (rebuilt with the unsigned memcmp, 2026-10-09) |
| pkgconf | validated on x86 (3.0.7: build, install, test; replaces pkg-config 0.29) | validated 3.0.7 (rebootstrap, 2026-10-08) |
| python311 | validated | validated 3.11.17 (rebootstrap, 2026-10-08) |
| quake2 | validated (content-free dedicated-server startup test; no game data) | — |
| quickjs | validated | — |
| roboclient | validated (1.1 with `rc.dhcp` installs and tests clean on x86) | — |
| rsync | validated | — |
| sdl12 | validated | — |
| sed | validated | validated 4.0.9 (with pkg_cmp_shim; rebootstrap, 2026-10-08) |
| sudo | validated | — |
| tar | 1.15.1 validated | validated 1.15.1 (rebootstrap, 2026-10-08) |
| tcsh | validated | validated 6.24.13 (rebootstrap, 2026-10-08; vfork.h fix) |
| termcap | validated | validated 1.3.1 (rebootstrap, 2026-10-08) |
| texinfo | validated | validated 4.8 (rebootstrap, 2026-10-08) |
| top | validated | validated 3.6.1 |
| unzip | validated | validated 6.0 (rebootstrap, 2026-10-08) |
| utf8proc | validated | — |
| vim | validated | validated 9.2.0121 (tree is now 9.2.1091: needs retest) |
| vlc | 0.9.10 validated (runs as root) | — |
| wget | 1.25.0 validated on x86 (HTTPS via OpenSSL; SPARC untested) | 1.25.0 untested |
| wget-bootstrap | 1.19.5 validated | validated 1.19.5 (needs the localtime and unsigned-compare fixes; rebootstrap, 2026-10-08) |
| xxhash | validated (manual build, after replacing `ln -sf`; rebuilt on a fresh host) | validated 0.8.4 (`XXH_FORCE_MEMORY_ACCESS=0`: the default packed-union reads bus-error with gcc 4.2; compiling `xxhash.c` is very slow; rebootstrap, 2026-10-08) |
| xz | validated | validated 5.8.4 |
| zip | validated | — |
| zlib | validated | validated 1.2.13 (rebootstrap, 2026-10-08) |
| zsh | validated | validated 5.9 |
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
