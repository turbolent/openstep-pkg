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
rebuilt from scratch in dependency order (2026-10-08): so far the packages marked "rebootstrap, 2026-10-08" or "2026-10-09" below have been
rebuilt, installed and tested there, including bash, curl, gcc42, tar, patch,
python311, expat, ca-certificates, openssl and openssh; vim, wget and the
remaining 20 or so packages are still to come.  The October 2026 security fixes are only partly covered on SPARC.  pkg itself gained a
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
below, bzip2, gzip, patch, tar and openssl have been rebuilt with them; wget, zip and
mpg123 have no SPARC result.

| Package | x86 | SPARC |
|---|---|---|
| bash | validated | validated 5.3 (rebuilt on the rebootstrapped host) |
| bison | validated | validated 2.4.3 (rebootstrap, 2026-10-08) |
| bzip2 | validated | validated 1.0.8 (rebootstrap, 2026-10-08) |
| ca-certificates | validated | validated 2026.09.25 (rebootstrap, 2026-10-08) |
| cctools-as | 806 validated | — |
| class-dump | validated | validated (2026-10-10; builds with `-arch $PKG_ARCH`) |
| coreutils | validated (rebuilt on a host with libiconv installed, iconv off, 2026-10-09) | validated 5.0 (rebuilt with the unsigned memcmp via pkg_cmp_obj, 2026-10-08) |
| curl | validated | validated 8.17.0 (rebuilt 2026-10-09 against the rebuilt libcrypto: links with the ostep_* routines from libcrypto.a, installs and tests) |
| diffutils | validated | validated 2.8.1 (2026-10-09) |
| duktape | validated | validated (2026-10-10; installed archive needs `ranlib`) |
| emacs | validated | validated (2026-10-10; needed the pdumper alignment fixes for the 64-bit wide-int Lisp_Object, and a SPARC `netinet/in.h` big-endian branch) |
| expat | validated | validated 2.9.0 (rebootstrap, 2026-10-08) |
| ffmpeg | validated | validated (2026-10-10) |
| findutils | validated | validated 4.2.33 |
| flex | validated | validated 2.5.39 (rebootstrap, 2026-10-08) |
| freetype | validated | validated 2.14.3 (2026-10-09) |
| freeze | validated | validated 2.5 (rebootstrap, 2026-10-08) |
| fribidi | 0.19.7 validated | validated 0.19.7 (2026-10-09) |
| gawk | validated | validated 3.1.8 (rebuilt with the unsigned memcmp via pkg_cmp_obj, 2026-10-08) |
| gcc42 | validated | validated 4.2.1-apple-5666.3 (port; bootstraps, compare passes, `pkg test` passes; clean rebuild on a rebootstrapped host, 2026-10-08) |
| git | validated | validated 2.55.0 (needs the unsigned memcmp/strcmp fix and -O0) |
| gperf | validated | validated 3.3 (2026-10-09) |
| grep | validated | validated 2.5.4 (rebuilt with the unsigned memcmp via pkg_cmp_obj, 2026-10-08) |
| gzip | validated | validated 1.3.12 (rebootstrap, 2026-10-08) |
| help2man | validated | validated 1.27 |
| jpeg | validated | validated 8d (rebootstrap, 2026-10-08) |
| less | validated | validated 710 (rebootstrap, 2026-10-08) |
| liba52 | validated | validated 0.7.4 (rebootstrap, 2026-10-08) |
| libcss | validated | validated 0.9.2 (2026-10-09) |
| libdom | validated | validated 0.4.2 (2026-10-09) |
| libgcrypt | 1.5.6 validated | validated 1.5.6 (2026-10-10; needs `-D__sparc_v8__` for the V8 udiv/umul in mpi) |
| libgpg-error | 1.12 validated | validated 1.12 (2026-10-09) |
| libhubbub | validated | validated 0.3.8 (2026-10-09) |
| libiconv | validated | validated 1.15 (rebootstrap, 2026-10-08) |
| libmad | validated | validated 0.15.1b (2026-10-09) |
| libmpeg2 | validated | — |
| libnsbmp | validated | validated 0.1.7 (2026-10-09) |
| libnsfb | validated | validated 0.2.2 (2026-10-09) |
| libnsgif | validated | validated (2026-10-10) |
| libnslog | validated | validated (2026-10-10) |
| libnsutils | validated | validated 0.1.1 (2026-10-09) |
| libparserutils | validated | validated 0.2.5 (rebootstrap, 2026-10-08) |
| libpng | validated | validated 1.6.59 (2026-10-09) |
| libsvgtiny | validated | validated 0.1.8 (2026-10-09) |
| libwapcaplet | validated | validated 0.4.3 (rebootstrap, 2026-10-08) |
| libxml2 | validated on x86 (2.15.4: build, install, test) | validated 2.15.4 (2026-10-09) |
| lua | validated | validated (2026-10-10) |
| lua51 | 5.1.5 validated | validated 5.1.5 (2026-10-10) |
| lz4 | validated | validated (2026-10-10) |
| m4 | validated | validated 1.4.6 (rebootstrap, 2026-10-08) |
| make | validated (built with the system cc) | validated 3.81 (built with the system cc; rebootstrap, 2026-10-08) |
| mktemp | validated | validated 1.7 (rebootstrap, 2026-10-08) |
| mpg123 | validated (1.33.7, with private stdint.h/inttypes.h shims; rebuilt on a fresh host) | — |
| nano | validated | validated 2.9.8 |
| ncurses | validated | validated 6.5 (rebootstrap, 2026-10-08) |
| nethack | validated (tty and X11) | validated 3.6.7 (`pkg test` passes, game starts; a stray "pkg: Stock: not found" after the install was a script replaced mid-run, fixed in pkg; rebootstrap, 2026-10-08) |
| netsurf-buildsystem | validated | validated 1.10 (rebootstrap, 2026-10-08) |
| neXtaw | validated | validated (2026-10-10) |
| nsgenbind | validated | validated 0.9 (2026-10-09; needed `-include stdlib.h -DYYMALLOC=malloc -DYYFREE=free`: the bison skeleton's own malloc prototype clashed with the system's) |
| ntp | validated (build, install, test; ntpdate and ntpd run against a server); on a fresh host configure's `setrlimit` check failed (prototype clash with `<sys/resource.h>`), so `ntp/build` supplies a no-op `ntp_rlimit()` (x86 rebuilt with it); `rc.ntp` boot script tested on Linux only | validated (2026-10-10; builds without `<memory.h>`/NetInfo, `sigsetjmp` mapped onto `setjmp`) |
| openssh | validated (10.6p1: sshd, ssh login by password and key, scp); `rc.sshd` boot script tested on Linux only | validated 10.6p1 (2026-10-09; builds and passes its tests, against the rebuilt libcrypto; needed `PICFLAG=` since the SPARC assembler cannot relocate the position-independent code that openbsd-compat is otherwise compiled as) |
| openssl | validated | validated 1.1.1w (rebuilt 2026-10-09 with the unsigned memcmp via pkg_cmp_named, which fixed OID lookups by DER bytes: SHA1, AES, SHA-2, secp384r1 and others had failed; the broadened `pkg test` passes: OIDs, digests, EC keys, signatures, chains, AES). The original failure is fixed: a secp384r1 key now round-trips through `openssl ec -pubout`. curl and openssh rebuilt against it link and pass their tests. Still to check on SPARC: `oidtest` recompiled (an old binary carries the old static library) |
| p7zip | validated | validated (2026-10-10) |
| patch | validated | validated 2.6.1 (rebootstrap, 2026-10-08) |
| pdksh | validated | validated 5.2.14 (rebootstrap, 2026-10-08) |
| perl | validated 5.8.9 (rebuilt on messer 2026-10-10, tests pass; the first make has bus-errored in ext/Encode on every clean build there, `perl/build` now retries it once, cause unknown) | validated 5.8.9 (rebuilt with the unsigned memcmp, 2026-10-09) |
| pkgconf | validated on x86 (3.0.7: build, install, test; replaces pkg-config 0.29) | validated 3.0.7 (rebootstrap, 2026-10-08) |
| python311 | validated | validated 3.11.17 (rebootstrap, 2026-10-08) |
| quake2 | validated (content-free dedicated-server startup test; no game data) | validated (2026-10-10; content-free dedicated-server startup test) |
| quickjs | validated | validated 2025-09-13-2 (2026-10-09) |
| roboclient | validated (1.1 with `rc.dhcp` installs and tests clean on x86) | validated 1.1 (2026-10-09) |
| rsync | validated | validated (2026-10-10) |
| sdl12 | validated | validated (2026-10-10; per-arch cc flags instead of a hardcoded -m486) |
| sed | validated | validated 4.0.9 (with pkg_cmp_shim; rebootstrap, 2026-10-08) |
| sudo | validated | validated 1.7.10p9 (2026-10-09) |
| tar | 1.15.1 validated | validated 1.15.1 (rebootstrap, 2026-10-08) |
| tcsh | validated | validated 6.24.13 (rebootstrap, 2026-10-08; vfork.h fix) |
| termcap | validated | validated 1.3.1 (rebootstrap, 2026-10-08) |
| texinfo | validated | validated 4.8 (rebootstrap, 2026-10-08) |
| top | validated | validated 3.6.1 (2026-10-09; needed work: the SPARC kernel refuses the `utask` read through /dev/kmem that holds the command name, so reads are non-fatal and names come from one `ps -axc` snapshot per refresh; the process list matches the x86 one; the earlier SPARC result was only an install) |
| unzip | validated | validated 6.0 (rebootstrap, 2026-10-08) |
| utf8proc | validated | validated (2026-10-10) |
| vim | validated | validated 9.2.1091 (rebuilt 2026-10-09) |
| vlc | 0.9.10 validated (runs as root) | — |
| wget | 1.25.0 validated on x86 (HTTPS via OpenSSL) | 1.25.0 validated (2026-10-10) |
| wget-bootstrap | 1.19.5 validated | validated 1.19.5 (needs the localtime and unsigned-compare fixes; rebootstrap, 2026-10-08) |
| xxhash | validated (manual build, after replacing `ln -sf`; rebuilt on a fresh host) | validated 0.8.4 (`XXH_FORCE_MEMORY_ACCESS=0`: the default packed-union reads bus-error with gcc 4.2; compiling `xxhash.c` is very slow; rebootstrap, 2026-10-08) |
| xz | validated | validated 5.8.4 |
| zip | validated | validated 3.0 (2026-10-09) |
| zlib | validated | validated 1.2.13 (rebootstrap, 2026-10-08) |
| zsh | validated | validated 5.9 |
| zstd | validated | rebuilt 2026-10-09 with memcpy memory access (MEM_FORCE_MEMORY_ACCESS=0); tests clean |

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
- **ntp** is 4.2.8p18 (ntpsec needs pthreads, which OPENSTEP lacks); `ntpd`
  installs into `sbin` and a default `ntpd.conf` is copied into place only if
  none exists.
- A failed build can be resumed with `PKG_RESUME=1` (see `README.md`).
- **git** on SPARC builds at `-O0` and uses unsigned `memcmp`/`strcmp`/`strncmp`
  replacements: the SPARC libc compares bytes as signed, which corrupted pack
  indexes.  Packages that rely on byte-order comparisons use `pkg_cmp_shim`
  (see `README.md`); their SPARC rebuilds are still pending.
