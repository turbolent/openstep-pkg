# Package status

Which packages have been built, installed and tested on real (emulated)
OPENSTEP, and where.  "validated" means the package built, installed and its
`test` hook passed.  "—" means no result has been recorded, not that it fails.

Last updated 2026-10-06.  Results come from test runs on the x86 and SPARC
OPENSTEP 4.2 machines; most packages have only been tried on x86 so far.  M68k
has not been attempted.

| Package | x86 | SPARC |
|---|---|---|
| bash | validated | — |
| bison | validated | validated |
| bzip2 | validated | validated |
| ca-certificates | validated | validated |
| cctools-as | 806 validated | — |
| class-dump | validated | — |
| coreutils | validated | validated |
| curl | validated | validated |
| diffutils | validated | — |
| duktape | validated | — |
| emacs | validated | — |
| expat | validated | validated |
| ffmpeg | validated | — |
| findutils | validated | validated |
| flex | validated | validated |
| freetype | validated | — |
| freeze | validated | validated |
| fribidi | — | — |
| gawk | validated | validated |
| gcc42 | validated | validated (port; bootstraps, compare passes, `pkg test` passes) |
| git | validated | — |
| gperf | validated | — |
| grep | validated | validated |
| gzip | validated | — |
| help2man | validated | validated |
| jpeg | validated | — |
| less | validated | — |
| lha | validated | — |
| liba52 | validated | — |
| libcss | validated | — |
| libdom | validated | — |
| libgcrypt | — | — |
| libgpg-error | — | — |
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
| make | validated | validated |
| mktemp | validated | validated |
| mpg123 | validated | — |
| nano | validated | validated |
| ncurses | validated | validated |
| nethack | validated (tty and X11) | — |
| netsurf-buildsystem | validated | — |
| neXtaw | validated | — |
| nsgenbind | validated | — |
| ntp | validated (build, install, test; ntpdate and ntpd run against a server) | — |
| openssh | validated (10.6p1: sshd, ssh login by password and key, scp) | 10.6p1 untested (7.9p1 was validated) |
| openssl | validated | validated |
| p7zip | validated | — |
| patch | validated | validated |
| pdksh | validated | validated |
| perl | validated | validated |
| pkgconf | validated on x86 (3.0.7: build, install, test; replaces pkg-config 0.29) | — |
| python311 | validated | — |
| quake2 | validated (content-free dedicated-server startup test; no game data) | — |
| quickjs | validated | — |
| roboclient | validated | — |
| rsync | validated | — |
| sdl12 | validated | — |
| sed | validated | validated |
| sudo | validated | — |
| tar | 1.15.1 validated | — |
| tcsh | validated | — |
| termcap | validated | — |
| texinfo | validated | validated |
| top | validated | validated |
| unzip | validated | validated |
| utf8proc | validated | — |
| vim | validated | validated |
| vlc | — | — |
| wget | 1.25.0 validated on x86 (HTTPS via OpenSSL; SPARC untested) | 1.25.0 untested |
| wget-bootstrap | — | — |
| xxhash | validated | fix pushed (manual build); no result recorded |
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
