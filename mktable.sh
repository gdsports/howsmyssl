#!/bin/sh
gawk -f mktable.awk mkr1010.txt feather_wifi101.txt esp32.txt esp8266_bearssl.txt  esp8266_bearssl_basic.txt  esp8266_axtls.txt >table.md
