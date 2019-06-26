#!/bin/bash
IDEVER="1.8.9"
WORKDIR="/tmp/autobuild_$$"
mkdir -p ${WORKDIR}
# Install Ardino IDE in work directory
if [ -f ~/Downloads/arduino-${IDEVER}-linux64.tar.xz ]
then
    tar xf ~/Downloads/arduino-${IDEVER}-linux64.tar.xz -C ${WORKDIR}
else
    wget -O arduino.tar.xz https://downloads.arduino.cc/arduino-${IDEVER}-linux64.tar.xz
    tar xf arduino.tar.xz -C ${WORKDIR}
    rm arduino.tar.xz
fi
# Create portable sketchbook and library directories
IDEDIR="${WORKDIR}/arduino-${IDEVER}"
LIBDIR="${IDEDIR}/portable/sketchbook/libraries"
mkdir -p "${LIBDIR}"
export PATH="${IDEDIR}:${PATH}"
cd ${IDEDIR}
which arduino
arduino --install-boards "arduino:sam"
cd ${LIBDIR}
git clone https://github.com/adafruit/WiFiNINA
arduino --install-library "ArduinoJson"
arduino --pref "compiler.warning_level=default" --save-prefs
#arduino --pref "boardsmanager.additional.urls=https://arduino.esp8266.com/stable/package_esp8266com_index.json,https://dl.espressif.com/dl/package_esp32_index.json,https://adafruit.github.io/arduino-board-index/package_adafruit_index.json" --save-prefs
BOARD="arduino:avr:uno"
arduino --board "${BOARD}" --save-prefs
CC="arduino --verify --board ${BOARD}"
cd ${IDEDIR}/portable/sketchbook
if [ -d ~/Sync ]
then
ln -s ~/Sync/howsmyssl/howsmyssl .
ln -s ~/Sync/howsmyssl/weathergov .
ln -s ~/Sync/howsmyssl/randomfox .
else
cd ${WORKDIR}
git clone https://github.com/gdsports/howsmyssl
ln -s ${WORKDIR}/howsmyssl/howsmyssl .
ln -s ${WORKDIR}/howsmyssl/weathergov .
ln -s ${WORKDIR}/howsmyssl/randomfox .
fi
(find -L . -name '*.ino' -print0 | grep -z -v libraries | xargs -0 -n 1 $CC >/tmp/m0_$$.txt 2>&1) &
# Uno
BOARD="arduino:avr:uno"
CC="arduino --verify --board ${BOARD}"
(find -L . -name '*.ino' -print0 | grep -z -v libraries | xargs -0 -n 1 $CC >/tmp/esp32_$$.txt 2>&1) &
# Mega 2560
BOARD="arduino:avr:mega2560"
CC="arduino --verify --board ${BOARD}"
(find -L . -name '*.ino' -print0 | grep -z -v libraries | xargs -0 -n 1 $CC >/tmp/esp32_$$.txt 2>&1) &
# Due
arduino --install-boards "arduino:sam"
BOARD="arduino:sam:arduino_due_x_dbg"
CC="arduino --verify --board ${BOARD}"
(find -L . -name '*.ino' -print0 | grep -z -v libraries | xargs -0 -n 1 $CC >/tmp/esp8266_$$.txt 2>&1) &
# Due native
BOARD="adafruit:samd:adafruit_feather_m0"
BOARD="arduino:sam:arduino_due_x"
CC="arduino --verify --board ${BOARD}"
(find -L . -name '*.ino' -print0 | grep -z -v libraries | xargs -0 -n 1 $CC >/tmp/atwinc1500_$$.txt 2>&1) &
