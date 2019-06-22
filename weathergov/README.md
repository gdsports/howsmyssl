# USA National Weather Service Forcast

(weather.gov)[https://www.weather.gov/about/] is a service of the US National
Weather Service (NWS). The NWS mission is to "provide weather, water, and
climate data, forecasts and warnings for the protection of life and property
and enhancement of the national economy".

This Arduino sketch demonstrates how to access weather forecasts from
weather.gov. Registration and API key are not required so this service is easy
to use. TLS (formerly known as SSL) is required but modern WiFi boards can
handle TLS.

The sketch has been tested on the following boards:

* ESP32
* ESP8266
* MKR WiFi 1010 (WiFiNINA)
* Adafruit M0 with ATWINC1500 (similar to MKR WiFi 1000) (WiFi101)

The amount of RAM required to buffer the response from weather.gov is too large
for AVR processors. I doubt this will work on Uno WiFi or Rev 2 or Mega 2650
with WiFi shield. Due with WiFi shield should work but has not been tested.

(https://forecast-v3.weather.gov/documentation)[https://forecast-v3.weather.gov/documentation]

## Library Dependencies

* ArduinoJson
* WiFiNINA
* WiFi101
