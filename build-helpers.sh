#!/bin/sh

CONFIG_SHELL=${CONFIG_SHELL-/usr/local/bin/ksh}

run_configure() {
    if [ ! -x "$CONFIG_SHELL" ]; then
        echo "error: CONFIG_SHELL not executable: $CONFIG_SHELL" >&2
        exit 1
    fi

    export CONFIG_SHELL
    CONFIG_SHELL="$CONFIG_SHELL" "$CONFIG_SHELL" ./configure CONFIG_SHELL="$CONFIG_SHELL" "$@"
}
