# gcc42 on sparc-next-openstep4

Status: **bootstraps and passes `pkg test gcc42` on OPENSTEP/SPARC (sun4m).**
A three-stage bootstrap with the stock cc 2.7.2.1 as stage 0 completes, the
stage 2/3 comparison passes, and the C, C++, Objective-C and Objective-C++
tests (including Objective-C struct returns and forwarding) pass at `-O0` and `-O2`.

It was verified by resuming an existing build tree (`GCC42_RESUME=1`) after
fixes, not by one clean `pkg build` from the final patch; a clean rebuild
(which needs none of the workarounds below) has not been run.

## How it works

- Apple's tree has no SPARC back end.  `gcc-sparc-config-4.2.1.tar.gz` holds the FSF
  GCC 4.2.1 `gcc/config/sparc` files, unpacked over the source before the patch.
- `gcc/config.gcc`: `sparc-next-*` uses `sparc/sparc.h nextstep.h sparc/next.h`,
  `with_cpu=v8` (OPENSTEP runs only on sun4m).
- `sparc/next.h` is the SPARC counterpart of `i386/next.h`; `sparc/t-next` copies
  `/NextDeveloper/Headers/*/sparc` to `include/*/__next_sparc__`.
- `gcc42/build`, `test` and `post-install` pick the target from `arch(1)`
  (`GCC42_ARCH` overrides; i386 is the default).

## What differed from i386 (and why)

Found by running the native `cc -S` and the stock `as`/`ld` on the real system:

- **Assembler spellings.**  The stock `as` has NeXT/BSD spellings, not Sun's:
  `.globl`, `.short`/`.long` (not `.half`/`.word`; `.word` is 16-bit on the i386 NeXT
  `as`), `.comm sym,size`, `.lcomm sym,size,log2align`, `.space`, `.align log2`,
  no `.ua*`.  `sparc/next.h` and a guard in `sparc.c` (`SPARC_NO_SUN_DATA_OPS`) set these.
- **No exported `.lcomm`.**  `sparc.h` emitted `int x = 0;` as `.globl` + `.lcomm`, which
  `as` keeps file-local (`undefined _have_error`).  `ASM_OUTPUT_ALIGNED_BSS` is
  undefined so such data goes in `.data` with `.space`, as on i386.
- **Direct calls, no PIC stubs.**  Native cc calls library routines through Darwin-style
  lazy stubs; this port emits direct calls like i386, which links and runs.
- **Duplicate libc symbols.**  Direct calls make `ld` extract libiberty's `getopt.o`,
  whose `opterr/optind/optopt` System also defines; `ld` rejects that unless given
  `-m`.  The sparc bootstrap passes `BOOT_LDFLAGS=-Wl,-m`.
- **No `objc_msgSend_stret`.**  The runtime has no stret/fpret messengers.  The hidden
  struct pointer is in the stack slot `[%sp+64]`, not an argument register, so plain
  `objc_msgSend` works; `objc-act.c` skips the stret/fpret selection when the target
  defines `STRUCT_VALUE_OFFSET` (i386 uses `NEXTSTEP_STRUCT_VALUE_REGNUM`).
- **Stock cc 2.7.2.1 crashes on an empty initializer.**  c-common.c's default
  `TARGET_IASM_OP_CONSTRAINT` was `{}`; it now has one entry no opcode matches.
- Shared NeXT code: `nextstep.c` calls an optional `NEXTSTEP_CPU_FILE_END`
  (i386 supplies `ix86_file_end`); the include-path guard also covers cross builds.

## Known limits / not verified

- `long double` is 64-bit (no `_Q_*` software quad routines were assumed).
- Only the V8 default has been exercised.
- Struct return uses the standard SPARC convention (`unimp` word after the call).
- Case-vectors use absolute `.long` entries; PIC code (`-fpic`) is untested.

## Resuming and debugging a build

- `GCC42_RESUME=1` skips patch/configure and continues in place; run the build
  script from inside the extracted source directory, with the image directory and
  version as arguments (see `pkg`).  Re-running `pkg install gcc42` then uses the
  staged image.
- `GCC42_BOOT_EXTRA_CFLAGS` adds flags to the stage 2/3 compiles only.
- `sparc-asm/` holds sample C/C++/Objective-C inputs, the assembly this port generates
  for them, and `check-asm.sh`, which assembles every sample with the system `as`.
  `native-data.c` is for comparing data directives against the native cc.
