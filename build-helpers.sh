#!/bin/sh

CONFIG_SHELL=${CONFIG_SHELL-/usr/local/bin/ksh}

# run_configure ARGS...
# Runs ./configure under $CONFIG_SHELL (default /usr/local/bin/ksh).  A build
# that needs a different shell can set CONFIG_SHELL itself (and depend on the
# package that provides it, e.g. bash), and setting PKG_CONFIG_SHELL in the
# environment overrides it for every package:
#   PKG_CONFIG_SHELL=/usr/local/bin/bash pkg build sudo
run_configure() {
    if [ -n "${PKG_CONFIG_SHELL-}" ]; then
        CONFIG_SHELL=$PKG_CONFIG_SHELL
    fi

    if [ ! -x "$CONFIG_SHELL" ]; then
        echo "error: CONFIG_SHELL not executable: $CONFIG_SHELL" >&2
        exit 1
    fi

    export CONFIG_SHELL
    CONFIG_SHELL="$CONFIG_SHELL" "$CONFIG_SHELL" ./configure CONFIG_SHELL="$CONFIG_SHELL" "$@"
}

# pkg_arch_flags COMPILER...
# Print the default architecture flags pkg exports for the given compiler
# command: gcc-4.2 and friends get PKG_GCC42_ARCH_FLAGS, anything else (the
# system cc) gets PKG_SYSCC_ARCH_FLAGS.  Example:
#   CC=/usr/local/bin/gcc-4.2; CFLAGS="-O2 `pkg_arch_flags $CC`"
pkg_arch_flags() {
    for pkg_arch_cc in $1; do break; done

    case `basename "$pkg_arch_cc"` in
        gcc-4.2|g++-4.2|c++-4.2|cpp-4.2)
            echo "$PKG_GCC42_ARCH_FLAGS"
        ;;
        *)
            echo "$PKG_SYSCC_ARCH_FLAGS"
        ;;
    esac
}

# pkg_step NAME COMMAND [ARG...]
# Run COMMAND, then record NAME as done in the build directory.  With
# PKG_RESUME set (pkg resumes the build tree of a failed run), a step that
# already completed is skipped, unless it is listed in PKG_REDO:
#   PKG_RESUME=1 pkg install sudo                      # pick up where it stopped
#   PKG_RESUME=1 PKG_REDO=configure pkg install sudo   # ...but configure again
pkg_step() {
    pkg_step_name=$1
    shift

    if [ -n "${PKG_RESUME-}" ] && [ -f ".pkg-step-$pkg_step_name" ]; then
        case " ${PKG_REDO-} " in
            *" $pkg_step_name "*)
                :
            ;;
            *)
                echo "==> resuming: step $pkg_step_name already done, skipping"
                return 0
            ;;
        esac
    fi

    "$@"
    : > ".pkg-step-$pkg_step_name"
}

# pkg_apply_patch PATCHFILE [STRIP]
# Apply PATCHFILE (default -p1) and keep a copy of what was applied.  When the
# build is resumed and PATCHFILE has changed since, the old patch is reversed
# first, so a patch can be edited and the same tree rebuilt incrementally.
pkg_apply_patch() {
    pkg_patch_file=$1
    pkg_patch_strip=${2-1}
    pkg_patch_copy=.pkg-patch-`basename "$pkg_patch_file"`

    if [ -f "$pkg_patch_copy" ]; then
        if cmp -s "$pkg_patch_copy" "$pkg_patch_file"; then
            echo "==> resuming: $pkg_patch_file already applied, skipping"
            return 0
        fi
        echo "==> resuming: $pkg_patch_file changed, reversing the old version"
        patch -R -p$pkg_patch_strip < "$pkg_patch_copy"
        /bin/rm -f "$pkg_patch_copy"
    fi

    patch -p$pkg_patch_strip < "$pkg_patch_file"
    /bin/cp "$pkg_patch_file" "$pkg_patch_copy"
}

# NB: the stock /bin/cc silently IGNORES "-include FILE", so pkg_cmp_shim does
# nothing for it; use it only with gcc-4.2.  For the system cc use pkg_cmp_obj
# (a program) or pkg_cmp_named (a library).
#
# pkg_cmp_shim DIR
# OPENSTEP's SPARC libc compares bytes as signed in memcmp() (for 20 bytes, and
# so for any word-sized and larger input) and strcmp(), so data with bytes of
# 0x80 or more sorts wrongly: git's pack indexes came out corrupt.  This writes
# DIR/ostep-cmp.h, which defines correct unsigned versions as static inline
# functions and renames memcmp, strcmp and strncmp to them, and prints the
# "-include DIR/ostep-cmp.h" flag for the package to add to its CFLAGS.  It
# prints nothing, and writes nothing, on machines whose libc is fine (x86) or
# when PKG_UNSIGNED_CMP=0; PKG_UNSIGNED_CMP=1 forces it on.  Example:
#   CFLAGS="$CFLAGS `pkg_cmp_shim \`pwd\`/openstep`"
pkg_cmp_shim() {
    cs_dir=$1

    case ${PKG_UNSIGNED_CMP-} in
        0)
            return 0
        ;;
        1)
            :
        ;;
        *)
            [ "${PKG_ARCH-}" = sparc ] || return 0
        ;;
    esac

    [ -d "$cs_dir" ] || mkdir "$cs_dir" || return 1
    /bin/cat > "$cs_dir/ostep-cmp.h" <<'CSEOF'
#ifndef OSTEP_CMP_H
#define OSTEP_CMP_H
#include <stddef.h>
#include <string.h>
static __inline int
ostep_memcmp(const void *a, const void *b, size_t n)
{
    const unsigned char *p = (const unsigned char *) a;
    const unsigned char *q = (const unsigned char *) b;

    while (n-- > 0) {
        if (*p != *q)
            return *p < *q ? -1 : 1;
        p++;
        q++;
    }
    return 0;
}
static __inline int
ostep_strcmp(const char *a, const char *b)
{
    const unsigned char *p = (const unsigned char *) a;
    const unsigned char *q = (const unsigned char *) b;

    while (*p != 0 && *p == *q) {
        p++;
        q++;
    }
    return *p == *q ? 0 : (*p < *q ? -1 : 1);
}
static __inline int
ostep_strncmp(const char *a, const char *b, size_t n)
{
    const unsigned char *p = (const unsigned char *) a;
    const unsigned char *q = (const unsigned char *) b;

    while (n > 0 && *p != 0 && *p == *q) {
        p++;
        q++;
        n--;
    }
    if (n == 0)
        return 0;
    return *p == *q ? 0 : (*p < *q ? -1 : 1);
}
#define memcmp ostep_memcmp
#define strcmp ostep_strcmp
#define strncmp ostep_strncmp
#endif
CSEOF
    echo "-include $cs_dir/ostep-cmp.h"
}

# pkg_cmp_obj DIR
# The same fix as pkg_cmp_shim, for packages whose gnulib wrappers cannot be
# preceded by a forced -include (they insist on config.h coming first): writes
# DIR/ostep-cmp.c with unsigned memcmp(), strcmp() and strncmp() definitions,
# compiles it with $CC, and prints the object's path.  Add that to LDFLAGS at
# make time: the program's own definitions win over libc's.  Prints nothing on
# machines whose libc is fine, or with PKG_UNSIGNED_CMP=0 (=1 forces it on).
pkg_cmp_obj() {
    co_dir=$1

    case ${PKG_UNSIGNED_CMP-} in
        0)
            return 0
        ;;
        1)
            :
        ;;
        *)
            [ "${PKG_ARCH-}" = sparc ] || return 0
        ;;
    esac

    [ -d "$co_dir" ] || mkdir "$co_dir" || return 1
    /bin/cat > "$co_dir/ostep-cmp.c" <<'COEOF'
#include <stddef.h>

int
memcmp(a, b, n)
    const void *a;
    const void *b;
    size_t n;
{
    const unsigned char *p = (const unsigned char *) a;
    const unsigned char *q = (const unsigned char *) b;

    while (n-- > 0) {
        if (*p != *q)
            return *p < *q ? -1 : 1;
        p++;
        q++;
    }
    return 0;
}

int
strcmp(a, b)
    const char *a;
    const char *b;
{
    const unsigned char *p = (const unsigned char *) a;
    const unsigned char *q = (const unsigned char *) b;

    while (*p != 0 && *p == *q) {
        p++;
        q++;
    }
    return *p == *q ? 0 : (*p < *q ? -1 : 1);
}

int
strncmp(a, b, n)
    const char *a;
    const char *b;
    size_t n;
{
    const unsigned char *p = (const unsigned char *) a;
    const unsigned char *q = (const unsigned char *) b;

    while (n > 0 && *p != 0 && *p == *q) {
        p++;
        q++;
        n--;
    }
    if (n == 0)
        return 0;
    return *p == *q ? 0 : (*p < *q ? -1 : 1);
}
COEOF
    $CC -fno-builtin -O -c "$co_dir/ostep-cmp.c" -o "$co_dir/ostep-cmp.o" || return 1
    echo "$co_dir/ostep-cmp.o"
}

# pkg_cmp_named DIR
# For a library that other programs link (so they cannot all be given an
# object, and the stock cc cannot take pkg_cmp_shim's -include): writes
# DIR/ostep-cmp-named.c with unsigned ostep_memcmp(), ostep_strcmp() and
# ostep_strncmp(), compiles it with $CC to DIR/ostep-cmp-named.o, and prints
# the compiler flags that rename memcmp, strcmp and strncmp to them.  Compile
# the package with those flags and add the object to the library (ar r), so
# that whatever links the library gets the definitions; a program that does not
# fails to link instead of quietly using the signed libc routines.  Prints
# nothing on machines whose libc is fine, or with PKG_UNSIGNED_CMP=0 (=1
# forces it on).
pkg_cmp_named() {
    cn_dir=$1

    case ${PKG_UNSIGNED_CMP-} in
        0)
            return 0
        ;;
        1)
            :
        ;;
        *)
            [ "${PKG_ARCH-}" = sparc ] || return 0
        ;;
    esac

    [ -d "$cn_dir" ] || mkdir "$cn_dir" || return 1
    /bin/cat > "$cn_dir/ostep-cmp-named.c" <<'CNEOF'
#include <stddef.h>

int
ostep_memcmp(a, b, n)
    const void *a;
    const void *b;
    size_t n;
{
    const unsigned char *p = (const unsigned char *) a;
    const unsigned char *q = (const unsigned char *) b;

    while (n-- > 0) {
        if (*p != *q)
            return *p < *q ? -1 : 1;
        p++;
        q++;
    }
    return 0;
}

int
ostep_strcmp(a, b)
    const char *a;
    const char *b;
{
    const unsigned char *p = (const unsigned char *) a;
    const unsigned char *q = (const unsigned char *) b;

    while (*p != 0 && *p == *q) {
        p++;
        q++;
    }
    return *p == *q ? 0 : (*p < *q ? -1 : 1);
}

int
ostep_strncmp(a, b, n)
    const char *a;
    const char *b;
    size_t n;
{
    const unsigned char *p = (const unsigned char *) a;
    const unsigned char *q = (const unsigned char *) b;

    while (n > 0 && *p != 0 && *p == *q) {
        p++;
        q++;
        n--;
    }
    if (n == 0)
        return 0;
    return *p == *q ? 0 : (*p < *q ? -1 : 1);
}
CNEOF
    $CC -fno-builtin -O -c "$cn_dir/ostep-cmp-named.c" -o "$cn_dir/ostep-cmp-named.o" || return 1
    echo "-Dmemcmp=ostep_memcmp -Dstrcmp=ostep_strcmp -Dstrncmp=ostep_strncmp"
}
