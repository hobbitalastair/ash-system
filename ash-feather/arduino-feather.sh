#!/usr/bin/bash
# Wrapper for arduino-builder to simplify dealing with Feather boards

for arg in "$@"; do
    if [ "${arg##*.}" == "ino" ]; then
        ino="${arg}"
    fi
done
if [ -z "${ino}" ]; then
    printf "%s: no ardunio sketch (.ino) detected on the command line\n" "$0" 1>&2
fi

build_path="/run/user/$(id -u)/arduino-build-${arg%.*}"
if [ ! -d "${build_path}" ]; then
    mkdir -p "${build_path}" || exit 1
fi

arduino-builder \
    -fqbn adafruit:avr:feather32u4 \
    -hardware /usr/share/arduino/hardware \
    -tools /usr/bin \
    -warnings all \
    -build-path "${build_path}" \
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
    "-Uflash:w:${build_path}/${ino}.hex:i" \
    || exit "$?"

sleep 3
stty -F /dev/ttyACM0 cs8 115200 ignbrk -brkint -imaxbel -opost -onlcr -isig -icanon -iexten -echo -echoe -echok -echoctl -echoke noflsh -ixon -crtscts
