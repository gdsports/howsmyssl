# randomfox.ca

Works using ESP8266 Bear SSL and ESP32. Both support Elliptic Curve algo
and SNI.

Fails on WiFi101/ATWINC1500 because the website requires Elliptic Curve but the
ATWINC1500 does not provide this crypto algo. The firmware/certifcate updater
will complains the root cert for this domain does not support RSA.

Fails on WiFiNINA because it does not support SNI (virtual server name).
