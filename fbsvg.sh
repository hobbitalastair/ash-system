#!/usr/bin/env sh
# Framebuffer SVG viewer, using rsvg-convert and fbv.

set -e
set -u

if [ "$#" -eq 0 ]; then
    printf "%s: <svg> <rsvg-convert arguments>\n" "$0"
    printf "Use fbv and rsvg-convert to render an svg to the framebuffer\n"
    exit 0
fi

outpng="$(mktemp "${TMPDIR:-/tmp}/svg-XXXX.png")"
rsvg-convert "$@" > "${outpng}"
fbv -f "${outpng}"

