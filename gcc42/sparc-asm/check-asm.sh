#!/bin/sh
# Assemble every sample .s with the system assembler and report problems.
# Run on OPENSTEP/SPARC from this directory:   sh check-asm.sh
# Set AS to use a different assembler (default /bin/as).
AS=${AS:-/bin/as}
TMPD=${TMPDIR:-/tmp}/check-asm.$$
mkdir $TMPD || exit 1
bad=0
for f in *.s; do
    if $AS -o $TMPD/x.o $f > $TMPD/log 2>&1 && [ ! -s $TMPD/log ]; then
        echo "$f: ok"
    else
        echo "$f: PROBLEMS"; bad=1
        sed 's/^/    /' $TMPD/log | sed -n 1,12p
    fi
done
rm -rf $TMPD
exit $bad
