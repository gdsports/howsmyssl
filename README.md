# Comparing Arduino TLS Stacks

[https://www.howsmyssl.com/](https://www.howsmyssl.com/) returns helpful
information about a TLS client such as TLS version number and possible security
issues. The rating "Probably Okay" is the highest possible rating.

howsmyssl has a REST API that returns a JSON string instead of HTML. The
Arduino program howsmyssl.ino uses this API and prints the results
on the serial console.

The following table summarizes the results. None of the boards received the "Bad"
rating. Four received the "Probably Okay" rating.

See the files such as esp32.txt and mkr1010.txt for the full listing of cipher
suites.

Board|TLS Version|Rating|Ephemeral keys supported|Session ticket supported|TLS compression supported|Unknown cipher suite supported|Beast vuln|Able to detect n minus one splitting
---|---|---|---|---|---|---|---|---
mkr1010| TLS 1.2| Probably Okay| 1| 1| 0| 0| 0| 0
feather_wifi101| TLS 1.2| Probably Okay| 1| 0| 0| 0| 0| 0
esp32| TLS 1.2| Probably Okay| 1| 1| 0| 0| 0| 0
esp8266_bearssl| TLS 1.2| Probably Okay| 1| 0| 0| 0| 0| 0
esp8266_bearssl_basic| TLS 1.2| Improvable| 0| 0| 0| 0| 0| 0
esp8266_axtls| TLS 1.2| Improvable| 0| 0| 0| 0| 0| 0
due_airlift| TLS 1.2| Probably Okay| 1| 1| 0| 0| 0| 0

MKR WiFi1010 uses an ESP32 running WiFiNINA firmware so it is not surprising to
see it has similar TLS characteristics as an ESP32 Arduino. One difference is
the ESP32 enables cipher suites with PSK (Pre-Shared Keys). This is not a
security problem but neither Chromium nor Firefox support TLS-PSK.

The default ESP8266 Bear SSL uses a full set of cipher suites similar to
ESP32/WiFiNINA including Elliptic Curve and Ephemeral keys. The basic options
supports the same cipher suites as the ESP8266 with AXTLS (no Elliptic Curve
and no Ephemeral keys).

ESP8266 AXTLS and Bear SSL basic receive the "Improvable" rating probably
because they does not support Ephemeral Keys.

ESP8266 AXTLS was run using ESP8266 Arduino Board package 2.4.2. The ESP8266
BearSSL tests were run with package 2.5.2.

The source code howsmyssl.ino handles all TLS stacks but at the cost of a lot
of #if conditionals. All cases use root CA certificate authentication. SHA1
fingerprint authentication is not safe and requires frequent updates.

The Adafruit Airlift shield (ESP32 running WiFiNINA firmware) works fine on an
Arduino Due. It has the same rating and cipher suites as the MKR WiFi 1010. The
limited RAM on Uno and Mega limit the usefulness shield but I can confirm it
works on Mega 2560.

The root CA certificate is included in the source code for the ESP32 and
ESP8266. The root CA certificate for the WiFi1010 (WiFiNINA) and ATWINC1500
(WiFi101)and must be loaded using the WiFi101/WiFiNINA Firmware/Certificates
Updater. The Adafruit Airlift has pre-loaded root certs that work for the
three examples.

## Library Dependencies

All can be installed using the IDE library manager.

ArduinoJson, WiFiNINA, WiFi101
