rahhid
======

Radioactive@Home HID driver based on `libhidapi` (with simple [ThingSpeak](https://thingspeak.com/) support).

[![Travis-CI](https://travis-ci.org/burghardt/rahhid.svg?branch=master)](https://travis-ci.org/burghardt/rahhid/)
[![CircleCI](https://circleci.com/gh/burghardt/rahhid/tree/master.svg?style=svg)](https://circleci.com/gh/burghardt/rahhid)
[![Coverity](https://scan.coverity.com/projects/6133/badge.svg)](https://scan.coverity.com/projects/6133)

Live ThingSpeak demo
--------------------

[Skierniewice Geiger counter](https://thingspeak.com/channels/52967) channels is updated using `rahhid`.

How to build this program?
------------------------

Install `libhidapi-dev` (Debian/Ubuntu) or equivalent:
```
# sudo apt-get update -qq
# sudo apt-get install libhidapi-dev
```

Compile `rahhid` with:
```
# make
```

Sensor test
-----------
Run `rahhid` without any arguments to measure for 30 seconds:
```
# ./rahhid
Switched LCD backlight off
Switched buzzer off
Reset counters... counting...
Clock: 29930, counts: 8
16.0374 CPM
0.0936765 microSv/h
16.0383 corrected CPM
0.0936815+-0.0331197 microSv/h
```

Uploading data to ThingSpeak
----------------------------
Supply API key as only argument to upload data to associated channel:

```
# ./rahhid "TS_API_KEY_HERE"
```

Use `cron` to upload data periodically:
```
# crontab -l
#m  h dom mon dow cmd
*/5 *  *   *   *  /usr/local/bin/rahhid "TS_API_KEY_HERE"
```

Building for OpenWRT
--------------------
Install `hidapi` and `libusb-1.0` packages on your OpenWRT device.
```
# opkg update
# opkg install hidapi libusb-1.0-0
```

Download [SDK package](http://wiki.openwrt.org/doc/howto/obtain.firmware.sdk)
for your OpenWRT version. Build `rahhid` package using
[my OpenWRT package feed](https://github.com/burghardt/openwrt-feed).

Finally install `rahhid_<version>_<arch>.ipk`.
```
# opkg install /tmp/rahhid_<version>_<arch>.ipk
```
