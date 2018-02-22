#!/usr/bin/bash
# Wrapper for arduino-builder to simplify dealing with Feather boards

build_path="$(mktemp --tmpdir="${TMPDIR:-/tmp}" -d "arduino-build-XXXX")" || exit 1
trap "rm -rf '${build_path}'" EXIT

arduino-builder \
    -fqbn adafruit:avr:feather32u4 \
    -hardware /usr/share/arduino/hardware \
    -tools /usr/bin \
    -warnings all \
    -build-path "${build_path}" \
    *.ino \
    "$@" \
    || exit "$?"

printf "%s: writing to feather in 3\n" "$0"
sleep 3
avrdude \
    -patmega32u4 \
    -cavr109 \
    -P/dev/ttyACM0 \
    -b57600 \
    -D \
    -v \
    "-Uflash:w:$(printf '%s' "${build_path}"/*.ino.hex):i" \
    || exit "$?"

sleep 2
stty -F /dev/ttyACM0 cs8 115200 ignbrk -brkint -imaxbel -opost -onlcr -isig -icanon -iexten -echo -echoe -echok -echoctl -echoke noflsh -ixon -crtscts
